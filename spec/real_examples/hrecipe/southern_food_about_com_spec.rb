# encoding: UTF-8
require 'hangry'
require 'rspec/its'

describe Hangry do

  context "southernfood.about.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/hrecipe/southernfood.about.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the correct parser" do
      expect(Hangry::ParserClassSelecter.new(@html).parser_class).to eq(Hangry::Parsers::NonStandard::SouthernFoodParser)
    end

    its(:author) { should == "Diana Rattray" }
    its(:canonical_url) { should == "http://southernfood.about.com/od/collardgreens/r/Kale-Saute-Recipe.htm" }
    its(:cook_time) { should == 13 }
    its(:description) { should == "Sauteed kale is a tasty way to enjoy fresh or frozen cooked kale. This frozen kale recipe is not only easy to prepare but nutritious and delicious." }
    its(:image_url) { should == "http://0.tqn.com/d/southernfood/1/0/r/Q/3/kale-saute-2.jpg" }
    its(:ingredients) {
      should == [
        "1 pound kale, large stems removed, chopped, or use frozen chopped kale", "2 teaspoons extra virgin olive oil",
        "1/2 cup finely chopped purple onion", "1 medium clove garlic, pressed",
        "1 or 2 hot peppers, minced, or 1 heaping tablespoon Portuguese crushed red peppers from a jar*",
        "3 tablespoons red wine vinegar", "1 tomato, chopped", "1/2 teaspoon salt, or to taste"
      ]
    }
    its(:name) { should == "Fresh or Frozen Kale With Garlic and Peppers" }
    its(:nutrition) do
      should == {
        calories: nil,
        cholesterol: nil,
        fiber: nil,
        protein: nil,
        saturated_fat: nil,
        sodium: nil,
        sugar: nil,
        total_carbohydrates: nil,
        total_fat: nil,
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
To cook the kale, bring a pot of salted water to a boil. Add the chopped kale and boil for 10 to 15 minutes, or until stem portions are tender. Or, follow directions on the package if using frozen kale.
Heat olive oil in a large skillet or sauté pan over medium heat; cook onion until just tender.
Add the garlic and cook, stirring, for 1 minute.
Add crushed red peppers, kale, and vinegar; cook, stirring, for 1 minute longer.
Add chopped tomato, salt, and pepper; heat through.
      EOS
      should == instructions.strip
    }

    its(:prep_time) { should == 12 }
    its(:published_date) { should == Date.parse('2011-08-22') }
    its(:total_time) { should == 25 }
    its(:yield) { should == "Serves 4 to 6" }

  end

end

