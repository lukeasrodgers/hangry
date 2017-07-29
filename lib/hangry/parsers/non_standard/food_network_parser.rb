module Hangry
  module Parsers
    module NonStandard
      class FoodNetworkParser < SchemaOrgRecipeParser

        def can_parse?
          canonical_url_matches_domain?('foodnetwork.com')
        end

        def parse_instructions
          node_with_itemprop(:recipeInstructions).css("p").map(&:content).join("\n")
        end

        def parse_description
          node_with_itemprop(:description)['content']
        end

      end
    end
  end
end

