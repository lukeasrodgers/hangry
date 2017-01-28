module Hangry
  module Parsers
    module NonStandard
      class NyTimesParser < SchemaOrgRecipeParser

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'nytimes.com') && new(html).recipe_ast
        end

        def self.ingredient_itemprop
          :recipeIngredient
        end

      end
    end
  end
end
