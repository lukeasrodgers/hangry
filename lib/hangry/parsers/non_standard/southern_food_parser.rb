module Hangry
  module Parsers
    module NonStandard
      class SouthernFoodParser < SchemaOrgRecipeParser

        def self.can_parse?(html)
          !CanonicalUrlParser.new(html).canonical_url.nil? && CanonicalUrlParser.new(html).canonical_url.include?('southernfood.about.com')
        end

        def parse_name
          # bug in website's DOM, extra space after headline
          headline = node_with_itemprop("headline").content
          headline.present? ? headliner : node_with_itemprop("headline ").content
        end

        def parse_description
          node_with_itemprop(:description)['content']
        end

        def parse_instructions
          node_with_itemprop("recipeInstructions").css("li").map(&:content).join("\n")
        end

        def parse_image_url
          node = node_with_itemprop(:image)
          node.css('meta[itemprop="url"]').first['content']
        end

      end
    end
  end
end

