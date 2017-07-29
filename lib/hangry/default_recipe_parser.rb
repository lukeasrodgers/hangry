module Hangry
  class DefaultRecipeParser < RecipeParser
    def self.can_parse?(*)
      true
    end

    def initialize(*)
    end

    def parse
      Recipe.new
    end
  end
end
