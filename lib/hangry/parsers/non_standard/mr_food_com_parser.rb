module Hangry
  module Parsers
    module NonStandard
      class MrFoodComParser < SchemaOrgRecipeParser

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'MrFood.com')
        end

        def self.ingredient_itemprop
          :recipeIngredient
        end
      end
    end
  end
end
