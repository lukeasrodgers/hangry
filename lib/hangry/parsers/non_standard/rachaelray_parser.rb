module Hangry
  module Parsers
    module NonStandard
      class RachaelRayParser < RecipeParser
        def can_parse?
          canonical_url_matches_domain?('rachaelray.com')
        end

        def self.root_selector
          'body'
        end

        def self.nutrition_selector
          'body'
        end

        def parse_author
          "Rachael Ray"
        end

        def parse_cook_time
          nil
        end

        def parse_prep_time
          nil
        end

        def parse_total_time
          nil
        end

        def parse_yield
          nil
        end

        def parse_published_date
          nil
        end

        def parse_description
          desc = nokogiri_doc.css('meta[property="og:description"]').first['content']
          if desc && desc.match(/RR/)
            # remove everying after -RR signoff, including the dash (which may not be a hyphen)
            return desc.match(/^(.+)RR/)[1][0..-2]
          else
            return desc
          end
        end

        def parse_image_url
          nil
        end

        def parse_ingredients
          nokogiri_doc.css('h2 + ul').first.css('li').map(&:content)
        end

        def parse_instructions
          nokogiri_doc.css('h2 + p').children.map(&:content).reject { |x| x.blank? }.map(&:strip).join("\n")
        end

        def parse_name
          nokogiri_doc.css('title').first.content.strip
        end

        def parse_nutrition
          recipe.nutrition
        end
      end
    end
  end
end
