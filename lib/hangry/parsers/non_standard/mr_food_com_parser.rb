module Hangry
  module Parsers
    module NonStandard
      class MrFoodComParser < SchemaOrgRecipeParser

        def can_parse?
          canonical_url_matches_domain?('MrFood.com')
        end

        def self.ingredient_itemprop
          :recipeIngredient
        end
      end
    end
  end
end
