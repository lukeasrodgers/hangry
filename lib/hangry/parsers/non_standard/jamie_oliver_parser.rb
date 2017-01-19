module Hangry
  module Parsers
    module NonStandard
      class JamieOliverParser < JsonLDParser

        def self.can_parse?(html)
          canonical_url_matches_domain?(html, 'jamieoliver.com')
        end

        private

        def parse_author
          "Jamie Oliver"
        end

        def parse_instructions
          # Some sites like may have their recipe instructions doubled if they
          # support different ways of presentation.
          # E.g. http://www.pillsbury.com/recipes/big-cheesy-pepperoni-pockets/a17766e6-30ce-4a0c-af08-72533bb9b449
          # has its steps doubled ("step by step" and "list" modes).
          nodes = nodes_with_itemprop(:recipeInstructions)
          nodes = [nodes].flatten
          html = nodes.map(&:strip).uniq.join("\n")
          Nokogiri::HTML(html.gsub(/<\/li><li>/, "\n")).content
        end
      end
    end
  end
end
