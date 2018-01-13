module Hangry
  module Parsers
    module NonStandard
      class AllRecipesParser < SchemaOrgRecipeParser

        def can_parse?
          canonical_url_matches_domain?('allrecipes.com')
        end

        def parse_name
          name = super
          if name.blank?
            name = nokogiri_doc.css('title').first.content.strip.sub(/-\s*Allrecipes.com$/,'')
          end
          name
        end

        def parse_description
          nodes = nodes_with_itemprop(:description)
          if nodes.present?
            nodes.last.content
          else
            ''
          end
        end

      end
    end
  end
end
