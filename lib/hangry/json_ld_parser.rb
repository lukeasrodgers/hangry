require 'hangry/canonical_url_parser'
require 'json'

module Hangry
  class JsonLDParser < SchemaOrgRecipeParser
    attr_accessor :nokogiri_doc, :recipe

    def self.root_selector
      'script[type="application/ld+json"]'
    end

    def self.ingredient_itemprop
      'recipeIngredient'
    end

    def initialize(nokogiri_doc)
      self.nokogiri_doc = nokogiri_doc
    end

    def can_parse?
      !recipe_hash.nil?
    end

    def recipe_hash
      return @recipe_hash if defined?(@recipe_hash)
      nokogiri_doc.css(self.class.root_selector).each do |script|
        json = JSON.parse(script.content.tr("\n", ''))
        return @recipe_hash = json if is_a_recipe?(json) && contains_required_keys?(json)
      end
      @recipe_hash = nil
    end

    def nutrition_hash
      return @nutrition_hash if defined?(@nutrition_hash)
      @nutrition_hash = recipe_hash && recipe_hash['nutrition']
    end

    private

    def is_a_recipe?(json)
      json.is_a?(Hash) && json['@context'] =~ /schema\.org/ && json['@type'] == 'Recipe'
    end

    def contains_required_keys?(json)
      json.key?('name') &&
      json.key?(self.class.ingredient_itemprop) &&
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
      node_with_itemprop(:author)
    end

    def parse_description
      node_with_itemprop(:description)
    end

    def parse_ingredients
      nodes_with_itemprop(self.class.ingredient_itemprop).map(&:strip).reject(&:blank?)
    end

    def parse_name
      node_with_itemprop(:name)
    end

    def parse_published_date
      content = node_with_itemprop(:datePublished)
      content.blank? ? nil : Date.parse(content)
    end

    def parse_yield
      value(node_with_itemprop(:recipeYield)) ||
      value(node_with_itemprop(:recipeYield)) ||
      NullObject.new
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
      nodes.map(&:strip).uniq.join("\n")
    end

    def parse_image_url
      node_with_itemprop(:image)
    end
  end
end
