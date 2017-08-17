module Hangry
  class DefaultRecipeParser < RecipeParser
    def can_parse?(*)
      true
    end

    def initialize(*)
    end

    def parse
      NullRecipe.new
    end
  end
end
