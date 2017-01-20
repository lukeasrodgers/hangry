module Hangry
  module Parsers
    module NonStandard
      class JamieOliverParser < JsonLDParser

        def self.can_parse?(html)
          new(html).nokogiri_doc.css('meta[name="author"]').first['content'] == "JamieOliver.com"
        rescue NoMethodError
          false
        end

        private

        def parse_author
          "Jamie Oliver"
        end

        def parse_instructions
          # JamieOliver.com has html inside json ld recipeInstructions node
          nodes = nodes_with_itemprop(:recipeInstructions)
          nodes = [nodes].flatten
          html = nodes.map(&:strip).uniq.join("\n")
          Nokogiri::HTML(html.gsub(/<\/li><li>/, "\n")).content
        end
      end
    end
  end
end
