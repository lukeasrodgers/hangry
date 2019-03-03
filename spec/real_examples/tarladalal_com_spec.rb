# encoding: UTF-8

describe Hangry do
  context "tarladalal.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/tarladalal.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the schema.org parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::SchemaOrgRecipeParser)
    end

    its(:author) { should == "Tarla Dalal" }
    its(:canonical_url) { should == "https://www.tarladalal.com/Vegetable-Fried-Rice-(-Jain-)-8631r" }
    its(:cook_time) { should == 6 }
    its(:description) { should == "All-time favourite Vegetable Fried Rice in a Jain-friendly version, made without onions, garlic and other no-no ingredients. You will find that this delicacy retains its authentic flavour and texture despite the absence of these ingredients, which you might have thought to be indispensable in the preparation of Vegetable Fried Rice. The use of typically Oriental veggies like cabbage, capsicum and baby corn, along with tongue-tickling sauces, gives this main-course rice dish a fantastic flavour and aroma, which you will thoroughly enjoy. It is also important to stick to the cooking times mentioned in the recipe because if you under-cook the veggies, they will have a raw smell, whereas if you over-cook them, you will miss the crunch that is so typical of Chinese foods." }
    its(:image_url) { should == "members/9306/big/big_5_spice_vegetable_fried_rice-10758.jpg?size=696X905" }
    its(:ingredients) {
      should == [
        '1/2 cup sliced capsicum (red , yellow and green)',
        '1/2 cup diagonally cut and blanched babycorn',
        '1/4 cup diagonally cut and blanched french beans',
        '1/2 cup shredded cabbage',
        '3 cups cooked long grained rice (basmati)',
        '2 tbsp oil',
        '1 tsp soy sauce',
        '1 tbsp chilli sauce',
        'salt and to taste'
      ]
    }
    its(:name) { should == "Vegetable Fried Rice ( Jain )" }
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
      should == "MethodHeat the oil in a deep non-stick pan, add the capsicum and sauté on a medium flame for 1 minute.Add the babycorn and french beans and sauté on a medium flame for 1 to 2 minutes.Add the cabbage and sauté on a medium flame for 1 minute.Add the soya sauce and chilli sauce and mix well.Add the cooked rice, salt and pepper, mix well and cook on medium flame for 2 minutes, while stirring occasionally.Serve hot."
    }
    its(:prep_time) { should == 15 }
    its(:published_date) { should == nil }
    its(:total_time) { should == 21 }
    its(:yield) { should == "Makes 3 servings" }
  end
end
