# encoding: UTF-8

describe Hangry do
  context "food.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/food.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:author) { should == "flume027" }
    its(:canonical_url) { should == "https://www.geniuskitchen.com/recipe/panda-express-orange-chicken-103215" }
    its(:cook_time) { should == 30 }
    its(:description) { should == "A copycat recipe from Panda Express. This chicken is tangy and flavorful. Give it a try! I'm sure you and your family will enjoy it." }
    its(:image_url) { should == "https://img.sndimg.com/food/image/upload/w_555,h_416,c_fit,fl_progressive,q_95/v1/img/recipes/10/32/15/W6FoUgXyRnaFTQjc1Nkw_0S9A2630.jpg" }
    its(:ingredients) {
      should == [
        "2 lbs boneless skinless chicken, chopped into bite-sized pieces",
        "1 egg",
        "1 1/2 teaspoons salt",
        "white pepper",
        "oil (for frying)",
        "1/2 cup cornstarch",
        "1/4 cup flour",
        "3 tablespoons soy sauce",
        "3/4 cup orange juice",
        "1/2 cup brown sugar",
        "1 orange, zest of",
        "1 tablespoon oil",
        "2 tablespoons gingerroot, minced",
        "2 teaspoons garlic, minced",
        "1 teaspoon red chili pepper flakes",
        "1/2 cup green onion, chopped",
        "2 tablespoons rice wine",
        "1/2 cup water",
        "2 tablespoons cornstarch",
        "1 teaspoon sesame oil"
      ]
    }
    its(:name) { should == "Panda Express Orange Chicken" }
    its(:nutrition) do
      should == {
        calories: '383.7',
        cholesterol: '128.1',
        fiber: '0.8',
        protein: '35.3',
        saturated_fat: '1.6',
        sodium: '1288.5',
        sugar: '20.9',
        total_carbohydrates: '39.6',
        total_fat: '8',
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      should == "Place chicken pieces in a large bowl, set aside.\nIn a medium bowl, stir egg, salt, pepper and 1 tablespoon oil and mix well, set aside.\nIn a medium bowl, stir together 1/2 cup of the cornstarch and the flour.\nHeat oil for deep-frying in wok or deep-fryer to 375 degrees.\nDip chicken pieces into egg mixture, then into the flour mixture, shaking off any excess.\nAdd chicken to wok in small batches and fry for 3 to 4 minutes or until golden brown.\n(Do not overcook chicken).\nRemove chicken from oil with slotted spoon and drain on paper towels; set aside.\nFOR THE SAUCE:.\nIn a small bowl, combine the soy sauce, orange juice, brown sugar and orange zest. Set aside.\nClean wok and heat 15 seconds over high heat.\nAdd 1 tablespoon oil, the gingerroot, garlic, crushed red chili pepper flakes and green onions and stir-fry for just a few seconds until fragrant.\nNow, add the rice wine and the soy sauce mixture you set aside above.\nAdd cooked chicken, stirring until well mixed.\nIn a small bowl, stir together the water and cornstarch, then add it to the wok and stir until sauce has thickened. Add sesame oil if desired.\nServe over jasmine rice."
    }
    its(:prep_time) { should == 15 }
    its(:published_date) { should == Date.new(2004, 11, 2) }
    its(:total_time) { should == 45 }
    its(:yield) { should == "6 serving(s)" }
  end
end
