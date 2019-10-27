# encoding: UTF-8

describe Hangry do
  context "copykat.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/copykat.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:author) { should == "Stephanie Manley" }
    its(:canonical_url) { should == "https://copykat.com/low-fat-scalloped-potatoes/" }
    its(:cook_time) { should == 40 }
    its(:description) { should == "You can remove the fat and keep the flavor.&nbsp;" }
    its(:image_url) { should == "https://copykat.com/wp-content/uploads/2014/12/swansons-finished-low-fat-scalloped-potatoes.jpg" }
    its(:ingredients) {
      should == [
        "1 pound Russet potatoes",
        "1 teaspoon salt",
        "1/2 teaspoon freshly ground black pepper",
        "26.1 ounces Low Fat Swanson's Cream Starter TM",
        "1 cup Cheddar cheese (optional)"
      ]
    }
    its(:name) { should == "Low Fat Scalloped Potatoes" }
    its(:nutrition) do
      should == {
        calories: "204 kcal",
        cholesterol: "24 mg",
        fiber: "1 g",
        protein: "8 g",
        saturated_fat: "4 g",
        sodium: "916 mg",
        sugar: "2 g",
        total_carbohydrates: "23 g",
        total_fat: "8 g",
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
Preheat oven to 350 degrees. Wash potatoes, and if desired peel before slicing. Spray an 8 x 8 inch baking dish with non-stick spray. Layer potatoes into baking dish, overlapping each slice over the previous one. When the bottom of the pan is covered, lightly season with salt and pepper. Continue layers until all of the potatoes are in the pan. Pour Swanson's Low Fat Cream Starter over the potatoes. Bake potatoes for about 30 minutes. Sprinkle cheese on potatoes and bake until the cheese is melted. Enjoy!
      EOS
      should == instructions.strip
    }
    its(:prep_time) { should == 15 }
    its(:published_date) { should == Date.new(2014, 12, 03) }
    its(:total_time) { should == 55 }
    its(:yield) { should == "6" }
  end
end
