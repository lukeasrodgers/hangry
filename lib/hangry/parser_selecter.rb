require 'hangry/recipe_parser'
require 'hangry/default_recipe_parser'
require 'hangry/hrecipe_parser'
require 'hangry/schema_org_recipe_parser'
require 'hangry/data_vocabulary_recipe_parser'
require 'hangry/json_ld_parser'

require 'hangry/parsers/non_standard/copykat_parser'
require 'hangry/parsers/non_standard/eating_well_parser'
require 'hangry/parsers/non_standard/epicurious_parser'
require 'hangry/parsers/non_standard/food_network_parser'
require 'hangry/parsers/non_standard/home_cooking_parser'
require 'hangry/parsers/non_standard/jamie_oliver_parser'
require 'hangry/parsers/non_standard/southern_food_parser'
require 'hangry/parsers/non_standard/taste_of_home_parser'
require 'hangry/parsers/non_standard/mr_food_com_parser'
require 'hangry/parsers/non_standard/rachaelray_parser'
require 'hangry/parsers/non_standard/nytimes_parser'
require 'hangry/parsers/non_standard/all_recipes_parser'

module Hangry
  class ParserSelector
    def initialize(nokogiri_doc)
      nokogiri_doc = Nokogiri::HTML(nokogiri_doc) if nokogiri_doc.is_a?(String)
      @nokogiri_doc = nokogiri_doc
    end

    def parser
      # Prefer the more specific parsers
      parser_classes = [
        Parsers::NonStandard::CopykatParser,
        Parsers::NonStandard::EatingWellParser,
        Parsers::NonStandard::EpicuriousParser,
        Parsers::NonStandard::FoodNetworkParser,
        Parsers::NonStandard::HomeCookingParser,
        Parsers::NonStandard::JamieOliverParser,
        Parsers::NonStandard::SouthernFoodParser,
        Parsers::NonStandard::TasteOfHomeParser,
        Parsers::NonStandard::MrFoodComParser,
        Parsers::NonStandard::RachaelRayParser,
        Parsers::NonStandard::NyTimesParser,
        Parsers::NonStandard::AllRecipesParser
      ]
      parser_classes += [SchemaOrgRecipeParser, HRecipeParser, DataVocabularyRecipeParser, JsonLDParser]
      parser_classes.each do |parser_class|
        parser = parser_class.new(@nokogiri_doc)
        return parser if parser.can_parse?
      end
      DefaultRecipeParser.new(@nokogiri_doc)
    end

  end
end
