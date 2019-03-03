# encoding: UTF-8

describe Hangry do
  context "mrfood.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/www.mrfood.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:author) { should == 'Ginsburg Enterprises' }
    its(:canonical_url) { should == "https://www.MrFood.com/Slow-Cooker-Recipes/Saucy-Italian-Pot-Roast-4268" }
    its(:cook_time) { should == 320 }
    its(:description) { should == "Try this saucy pot roast over egg noodles, rice, or-for more authentic Italian flavor-polenta. It's a winner whichever way you choose!" }
    its(:image_url) { should == "http://irepo.primecp.com/2015/09/235934/Saucy-Italian-Pot-Roast_ExtraLarge1000_ID-1183022.jpg?v=1183022" }
    its(:ingredients) {
      should == [
        "1 (8-ounce) package sliced fresh baby Portobello mushrooms",
        "1 large onion, cut in half and sliced",
        "1 (2-1/2- to 3-pound boneless chuck roast, trimmed",
        "1 (1.6-ounce) package garlic-and-herb sauce mix",
        "1/2 teaspoon crushed red pepper",
        "2 (14-1/2-ounce) cans Italian-style diced tomatoes, undrained",
        "1 (8-ounce) can no-salt-added tomato sauce",
        "2 tablespoons cornstarch",
        "2 tablespoons water"
      ]
    }
    its(:name) { should == "Saucy Italian Pot Roast" }
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

    its(:instructions) { should == "" }

    its(:prep_time) { should == nil }
    its(:published_date) { should == Date.new(2018, 5, 17) }
    its(:total_time) { should == nil }
    its(:yield) { should == nil }
  end
end
