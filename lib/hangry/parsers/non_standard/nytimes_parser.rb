module Hangry
  module Parsers
    module NonStandard
      class NyTimesParser < SchemaOrgRecipeParser

        def can_parse?
          canonical_url_matches_domain?('nytimes.com') && recipe_ast
        end

        def self.ingredient_itemprop
          :recipeIngredient
        end

      end
    end
  end
end
