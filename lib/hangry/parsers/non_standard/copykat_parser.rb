module Hangry
  module Parsers
    module NonStandard
      class CopykatParser < SchemaOrgRecipeParser

        def can_parse?
          canonical_url_matches_domain?('copykat.com')
        end

        def parse_author
          # => all from her?
          "Stephanie Manley via CopyKat.com"
        end

      end
    end
  end
end
