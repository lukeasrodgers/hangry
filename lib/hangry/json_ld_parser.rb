require 'hangry/canonical_url_parser'
require 'json'

module Hangry
  class JsonLDParser < SchemaOrgRecipeParser
    attr_reader :recipe_html
    attr_accessor :nokogiri_doc, :nutrition_hash, :recipe_hash, :recipe

    def self.root_selector
      'script[type="application/ld+json"]'
    end

    def self.ingredient_itemprop
      'recipeIngredient'
    end

    def initialize(recipe_html)
      @recipe_html = recipe_html
      @recipe = Recipe.new
      initialize_nutrition
      self.nokogiri_doc = Nokogiri::HTML(recipe_html)
      recipe_ld_script = nokogiri_doc.css(self.class.root_selector).first
      self.recipe_hash = recipe_ld_script && JSON.parse(recipe_ld_script.content.tr("\n", ''))
      self.nutrition_hash = recipe_hash && recipe_hash['nutrition']
    end

    def self.can_parse?(html)
      new(html).recipe_hash
    end

    private

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
