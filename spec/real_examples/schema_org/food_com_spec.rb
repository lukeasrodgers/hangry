# encoding: UTF-8
require 'hangry'
require 'rspec/its'

describe Hangry do

  context "food.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/schema_org/food.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    its(:author) { should == "flume027" }
    its(:canonical_url) { should == "http://www.food.com/recipe/panda-express-orange-chicken-103215" }
    its(:cook_time) { should == 30 }
    its(:description) { should == "A copycat recipe from Panda Express. This chicken is tangy and flavorful. Give it a try! I'm sure you and your family will enjoy it." }
    its(:image_url) { should == "http://img.sndimg.com/food/image/upload/w_555,h_416,c_fit,fl_progressive,q_95/v1/img/recipes/10/32/15/pic7atxk2.jpg" }
    its(:ingredients) {
      should == [
        "2 lbs boneless skinless chicken, chopped into bite sized pieces",
        "1 egg",
        "1 1/2 teaspoons salt",
        "white pepper",
        "oil (for frying)",
        "1/2 cup cornstarch, plus",
        "1 tablespoon cornstarch",
        "1/4 cup flour",
        "1 tablespoon gingerroot, minced",
        "1 teaspoon garlic, minced",
        "1/2 teaspoon red chili pepper flakes",
        "1/4 cup green onion, chopped",
        "1 tablespoon rice wine",
        "1/4 cup water",
        "1/2 teaspoon sesame oil",
        "1 1/2 tablespoons soy sauce",
        "1 1/2 tablespoons water",
        "5 tablespoons sugar",
        "5 tablespoons white vinegar",
        "1 orange, zest of"
      ]
    }
    its(:name) { should == "Panda Express Orange Chicken" }
    its(:nutrition) do
      should == {
        calories: '305.5',
        cholesterol: '128.1',
        fiber: '0.5',
        protein: '34.5',
        saturated_fat: '1.2',
        sodium: '1027.5',
        sugar: '10.8',
        total_carbohydrates: '26.7',
        total_fat: '5.2',
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      should == "Place chicken pieces in large bowl, set aside. In a medium bowl stir egg, salt, pepper and 1 tablespoon oil and mix well, set aside. In a medium bowl stir together 1/2 cup of the cornstarch and the flour. Coat chicken pieces with egg mixture, then add to flour mixture, stirring to coat. Heat oil for deep-frying in wok or deep-fryer to 375 degrees. Add chicken, small batches at a time, and fry 3 to 4 minutes or until golden crisp. (Do not overcook chicken). Remove chicken from oil with slotted spoon and drain on paper towels; set aside. Clean wok and heat 15 seconds over high heat. Add 1 tablespoon oil. Add ginger and garlic and stir-fry until fragrant; about 10 seconds. Add and stir-fry crushed chiles and green onions. Add rice wine and stir 3 seconds. Add Orange Sauce and bring to boil. Add cooked chicken, stirring until well mixed. Stir water into remaining 1 tablespoon cornstarch until smooth and add to chicken. Heat until sauce is thickned. Stir in sesame oil and orange zest if desired. Serve over jasmine rice."
    }
    its(:prep_time) { should == 15 }
    its(:published_date) { should == Date.parse("2004-11-02") }
    its(:total_time) { should == 45 }
    its(:yield) { should == "6 serving(s)" }

  end

end

