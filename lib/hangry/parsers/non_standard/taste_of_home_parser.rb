module Hangry
  module Parsers
    module NonStandard
      class TasteOfHomeParser < SchemaOrgRecipeParser

        def self.root_selector
          '[itemtype*="schema.org/recipe"]'
        end

        def can_parse?
          canonical_url_matches_domain?('tasteofhome.com')
        end

        def parse_name
          nokogiri_doc.css('meta[itemprop="name"]').first['content']
        end

        def parse_yield
          value(node_with_itemprop(:recipeyield).content)
        end

        def parse_instructions
          # => rd_directions.rd_ingredient each
          recipe_ast.css(".rd_directions").first.css(".rd_ingredient").map(&:content).join("\n")
        end

      end
    end
  end
end
