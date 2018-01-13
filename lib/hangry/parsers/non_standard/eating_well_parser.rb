module Hangry
  module Parsers
    module NonStandard
      class EatingWellParser < SchemaOrgRecipeParser
        def can_parse?
          canonical_url_matches_domain?('eatingwell.com')
        end

        def parse_instructions
          nodes_with_itemprop(:recipeInstructions).map(&:content).join("\n")
        end

        def parse_nutrition
          recipe.nutrition.tap do |nutrition|
            nutrition[:calories] = nutrition_property_value(:calories)
            nutrition[:cholesterol] = nutrition_property_value(:cholesterolContent)
            nutrition[:fiber] = nutrition_property_value(:fiberContent)
            nutrition[:protein] = nutrition_property_value(:proteinContent)
            nutrition[:saturated_fat] = nutrition_property_value(:saturatedFatContent)
            nutrition[:sodium] = nutrition_property_value(:sodiumContent)
            nutrition[:sugar] = nutrition_property_value(:sugarContent)
            nutrition[:total_carbohydrates] = nutrition_property_value(:carbohydrateContent)
            nutrition[:total_fat] = nutrition_property_value(:fatContent)
            nutrition[:trans_fat] = nutrition_property_value(:transfatContent)
            nutrition[:unsaturated_fat] = nutrition_property_value(:unsaturatedFatContent)
          end
        end

        def parse_yield
          value(node_with_itemprop(:recipeYield)['content']) || NullObject.new
        end

        def parse_description
          nokogiri_doc.css('meta[itemprop="description"]').first['content']
        end
      end
    end
  end
end
