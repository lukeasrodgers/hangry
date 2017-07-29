require "hangry/version"
require 'hangry/parser_selecter'
require 'hangry/recipe_attribute_cleaner'
require 'active_support/core_ext/object/blank'
require 'date'
require 'iso8601'
require "nokogiri"

module Hangry
  RECIPE_ATTRIBUTES = [
    :author,
    :canonical_url,
    :cook_time,
    :description,
    :image_url,
    :ingredients,
    :instructions,
    :name,
    :nutrition,
    :prep_time,
    :published_date,
    :total_time,
    :yield
  ]

  NUTRITION_ATTRIBUTES = [
    :calories,
    :cholesterol,
    :fiber,
    :protein,
    :saturated_fat,
    :sodium,
    :sugar,
    :total_carbohydrates,
    :total_fat,
    :trans_fat,
    :unsaturated_fat
  ]

  Recipe = Struct.new(*RECIPE_ATTRIBUTES)

  def self.parse(html)
    nokogiri_doc = Nokogiri::HTML(html)
    parser = ParserSelector.new(nokogiri_doc).parser
    recipe = parser.parse
    RecipeAttributeCleaner.new(recipe).clean
  end

end
