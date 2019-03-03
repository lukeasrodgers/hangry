# encoding: UTF-8

describe Hangry do
  context "pillsbury.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/www.pillsbury.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the schema.org parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::SchemaOrgRecipeParser)
    end

    its(:author) { should == "Pillsbury Kitchens" }
    its(:canonical_url) { should == "https://www.pillsbury.com/recipes/big-cheesy-pepperoni-pockets/a17766e6-30ce-4a0c-af08-72533bb9b449" }
    its(:cook_time) { should == nil }
    its(:description) { should == "Enjoy these cheesy pepperoni hand pies made using Pillsbury™ Big & Flaky or Big & Buttery crescents–a delicious dinner that’s ready in 35 minutes." }
    its(:image_url) { should == 'https://images-gmi-pmc.edge-generalmills.com/b8bebad1-e3d9-4987-9982-d01408d70748.jpg' }
    its(:ingredients) {
      should == [
        "1 can (12 oz) Pillsbury™ Grands!™ Big & Flaky refrigerated crescent dinner rolls or Grands!™ Big & Buttery refrigerated crescent dinner rolls",
        "4 tablespoons marinara sauce",
        "32 slices pepperoni (2.25 oz)",
        "1 1/3 cups shredded mozzarella cheese (5 oz)",
        "1/4 teaspoon Italian seasoning"
      ]
    }
    its(:name) { should == "Big & Cheesy Pepperoni Pockets" }
    its(:nutrition) do
      should == {
        calories: '510',
        cholesterol: '40 mg',
        fiber: '1 g',
        protein: '16 g',
        saturated_fat: '13 g',
        sodium: '1200 mg',
        sugar: '10 g',
        total_carbohydrates: '40 g',
        total_fat: '4',
        trans_fat: '1/2 g',
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
1
Heat oven to 375°F. Separate dough into 4 rectangles. Place on ungreased cookie sheet. Press each to 7x5 inches, firmly pressing perforations to seal.
2
Spread 1 tablespoon marinara sauce on each rectangle to within 1/2 inch of edges. Place 8 slices of pepperoni in center of each rectangle; top with 1/3 cup cheese and 8 more slices pepperoni. Bring ends up over filling, overlapping about 1 inch. Press edges with fork to seal. Brush each sandwich with water, and sprinkle with Italian seasoning.
3
Bake 13 to 15 minutes or until golden brown. Immediately remove from cookie sheet. Serve warm.
      EOS
      should == instructions.strip
    }
    its(:prep_time) { should == 15 }
    its(:published_date) { should == nil }
    its(:total_time) { should == 35 }
    its(:yield) { should == "4" }
  end
end
