require 'hangry/canonical_url_parser'
require 'oj'

module Hangry
  class JsonLDParser < SchemaOrgRecipeParser
    attr_accessor :nokogiri_doc, :recipe

    def self.root_selector
      'script[type="application/ld+json"]'
    end

    def initialize(nokogiri_doc)
      self.nokogiri_doc = nokogiri_doc
    end

    def can_parse?
      !recipe_hash.nil?
    end

    def recipe_hash
      return @recipe_hash if defined?(@recipe_hash)
      @recipe_hash = parse_recipe_hash
    end

    def nutrition_hash
      return @nutrition_hash if defined?(@nutrition_hash)
      @nutrition_hash = recipe_hash && recipe_hash['nutrition']
    end

    private

    def parse_recipe_hash
      nokogiri_doc.css(self.class.root_selector).each do |script|
        [Oj.load(script.content)].flatten.each do |json|
          next unless json.is_a?(Hash)
          next unless json['@context'] =~ /schema\.org/

          # b/c of www.thespruceeats.com in the specs
          json = json['mainEntity'] if json.dig('mainEntity', '@type') == 'Recipe'

          return json if is_a_recipe?(json)

          if json['@graph'].is_a?(Array)
            json['@graph'].each do |item|
              return item if is_a_recipe?(item)
            end
          end
        end
      end
      nil
    end

    def is_a_recipe?(json)
      json['@type'] == 'Recipe' && contains_required_keys?(json)
    end

    def contains_required_keys?(json)
      json.key?('name') &&
      (json.key?('recipeIngredient') || json.key?('ingredients')) &&
      json.key?('recipeInstructions')
    end

    def nodes_with_itemprop(itemprop)
      recipe_hash ? recipe_hash[itemprop.to_s] : NullObject.new
    end

    def nutrition_node_with_itemprop(itemprop)
      return NullObject.new unless nutrition_hash
      nutrition_hash[itemprop].first || NullObject.new
    end

    def node_with_itemprop(itemprop)
      nodes = nodes_with_itemprop(itemprop)
      if nodes.nil?
        NullObject.new
      elsif nodes.is_a?(Array)
        nodes.first
      else
        nodes
      end
    end

    def parse_author
      author = node_with_itemprop(:author)

      case author
      when Hash
        type = [author.fetch("@type")].flat_map(&:downcase)
        if type.member?("person") || type.member?("organization")
          return author.fetch("name")
        else
          raise NotImplementedError, "Unexpected type for `author`: #{type.inspect}"
        end
      when String
        author
      else
        raise NotImplementedError, "Unexpected node: #{author.inspect}"
      end
    end

    def parse_description
      node_with_itemprop(:description)
    end

    def parse_ingredients
      (nodes_with_itemprop('recipeIngredient') || nodes_with_itemprop('ingredients')).map(&:strip).reject(&:blank?)
    end

    def parse_name
      node_with_itemprop(:name)
    end

    def parse_published_date
      content = node_with_itemprop(:datePublished)
      content.blank? ? nil : Date.parse(content)
    end

    def parse_yield
      value(node_with_itemprop(:recipeYield)) || NullObject.new
    end

    def parse_time(type)
      node = node_with_itemprop(type)
      parse_duration(node)
    end

    def nutrition_node_with_itemprop(itemprop)
      return NullObject.new unless nutrition_hash
      nutrition_hash[itemprop.to_s] || nil
    end

    def nutrition_property_value(itemprop)
      nutrition_node = nutrition_node_with_itemprop(itemprop)
      nutrition_node ? nutrition_node.strip : nil
    end

    def parse_instructions
      # Some sites like may have their recipe instructions doubled if they
      # support different ways of presentation.
      # E.g. http://www.pillsbury.com/recipes/big-cheesy-pepperoni-pockets/a17766e6-30ce-4a0c-af08-72533bb9b449
      # has its steps doubled ("step by step" and "list" modes).
      nodes = nodes_with_itemprop(:recipeInstructions)
      nodes = [nodes].flatten
      parse_list_to_text(*nodes).uniq.join("\n")
    end

    def parse_list_to_text(*nodes)
      nodes.flat_map do |node|
        case node
        when String then [node]
        when Hash then parse_to_list(node)
        else fail NotImplementedError, "Unexpected node #{node.inspect}"
        end
      end
    end

    def parse_to_list(node)
      type = [node.fetch("@type")].flatten
      if type.member?("ItemList")
        node.fetch("itemListElement").flat_map(&method(:parse_to_list))
      elsif type.member?("ListItem") || type.member?("HowToStep")
        [node.fetch("text")]
      elsif type.member?("HowToSection")
        [node["name"], *parse_list_to_text(*node.fetch("itemListElement")), ""]
      else
        fail NotImplementedError, "Unexpected node @type #{type.inspect}"
      end
    end

    def parse_image_url
      url = node_with_itemprop(:image)
      url = url["url"] if url.is_a?(Hash) && url["@type"] == "ImageObject"
      url
    end
  end
end
