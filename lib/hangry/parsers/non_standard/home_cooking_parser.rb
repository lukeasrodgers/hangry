module Hangry
  module Parsers
    module NonStandard
      class HomeCookingParser < SchemaOrgRecipeParser

        def can_parse?
          canonical_url_includes?('homecooking.about.com')
        end

        def parse_description
          node_with_itemprop(:description)['content']
        end

        def parse_name
          # bug in website's DOM, extra space after headline
          headline = node_with_itemprop("headline").content
          headline.present? ? headliner : node_with_itemprop("headline ").content
        end

        def parse_image_url
          node = node_with_itemprop(:image)
          node.css('meta[itemprop="url"]').first['content']
        end
      end
    end
  end
end
