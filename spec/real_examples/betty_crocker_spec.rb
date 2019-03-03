# encoding: UTF-8

describe Hangry do
  context "bettycrocker.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/betty_crocker.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the schema.org parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::SchemaOrgRecipeParser)
    end

    its(:author) { should == "Betty Crocker Kitchens" }
    its(:canonical_url) { should == "https://www.bettycrocker.com/recipes/skillet-chicken-nachos/9bf0c3be-09dd-4b1b-8cf4-a9cfa979b232" }
    its(:cook_time) { should == nil }
    its(:description) { should == "Looking for a dinner ready in 20 minutes? This recipe's delicious nacho mixture is made in your skillet, then spooned onto tortilla chips and sprinkled with cheese and cilantro before serving." }
    its(:image_url) { should == 'https://images-gmi-pmc.edge-generalmills.com/5e36ef32-db65-43b3-ade9-8c32fbe7f1dd.jpg' }
    its(:ingredients) {
      should == [
        "1 tablespoon olive or vegetable oil", "1 1/4 lb boneless skinless chicken breasts, cut into 1/4-inch pieces",
        "1 package (1 oz) Old El Paso™ taco seasoning mix", "1 can (8 oz) tomato sauce", "1 medium red bell pepper, chopped (1 cup)",
        "1 can (15 oz) Progresso™ black beans, drained, rinsed", "1 can (7 oz) whole kernel sweet corn, drained",
        "2 cups shredded Mexican cheese blend (8 oz)", "6 oz tortilla chips (about 42 chips)", "1/4 cup chopped fresh cilantro"
      ]
    }
    its(:name) { should == "Skillet Chicken Nachos" }
    its(:nutrition) do
      should == {
        calories: '520',
        cholesterol: '95 mg',
        fiber: '5 g',
        protein: '36 g',
        saturated_fat: '9 g',
        sodium: '1320 mg',
        sugar: '4 g',
        total_carbohydrates: '38 g',
        total_fat: '4',
        trans_fat: '0 g',
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
1
In 12-inch nonstick skillet, heat oil over medium-high heat. Cook chicken in oil 3 to 5 minutes, stirring occasionally, until no longer pink in center.
2
Stir in taco seasoning mix, tomato sauce, bell pepper, beans, corn and 1 cup of the cheese. Reduce heat to medium; cook 3 to 5 minutes, stirring occasionally, until heated through and cheese is melted.
3
Divide tortilla chips between 6 plates. Spoon chicken mixture evenly over chips. Sprinkle with remaining 1 cup cheese and the cilantro.
      EOS
      should == instructions.strip
    }
    its(:prep_time) { should == 20 }
    its(:published_date) { should == nil }
    its(:total_time) { should == 20 }
    its(:yield) { should == "6" }
  end
end
