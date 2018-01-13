# encoding: UTF-8

describe Hangry do
  context "standard food network recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/food_network_schema_org.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:canonical_url) { should == 'http://www.foodnetwork.com/recipes/rachael-ray/spinach-and-mushroom-stuffed-chicken-breasts-recipe-2013365' }
    its(:cook_time) { should == 15 }
    its(:description) { should == "For an elegant dinner, try Rachael Ray's Spinach-and-Mushroom-Stuffed Chicken Breasts from 30 Minute Meals on Food Network, served with a white wine sauce." }
    its(:image_url) { should == 'http://food.fnr.sndimg.com/content/dam/images/food/fullset/2011/4/19/1/FN_chicken-breasts-006_s4x3.jpg.rend.hgtvcom.406.305.suffix/1371597945764.jpeg' }
    its(:ingredients) do
      should == [
        "4 boneless, skinless chicken breasts, 6 ounces",
        "Large plastic food storage bags or waxed paper",
        "1 package, 10 ounces, frozen chopped spinach",
        "2 tablespoons butter",
        "12 small mushroom caps, crimini or button",
        "2 cloves garlic, cracked",
        "1 small shallot, quartered",
        "Salt and freshly ground black pepper",
        "1 cup part skim ricotta cheese",
        "1/2 cup grated Parmigiano or Romano, a couple of handfuls",
        "1/2 teaspoon fresh grated or ground nutmeg",
        "Toothpicks",
        "2 tablespoons extra-virgin olive oil",
        "2 tablespoons butter",
        "2 tablespoons flour",
        "1/2 cup white wine",
        "1 cup chicken broth"
      ]
    end

    its(:instructions) do
      should == "Place breasts in the center of a plastic food storage bag or 2 large sheets of waxed paper. Pound out the chicken from the center of the bag outward using a heavy-bottomed skillet or mallet. Be firm but controlled with your strokes.\nDefrost spinach in the microwave. Transfer spinach to a kitchen towel. Twist towel around spinach and wring it out until very dry. Transfer to a medium-mixing bowl.\nPlace a nonstick skillet over moderate heat. When skillet is hot, add butter, mushrooms, garlic and shallot. Season with salt and pepper and saute 5 minutes. Transfer mushrooms, garlic and shallot to the food processor. Pulse to grind the mushrooms and transfer to the mixing bowl, adding the processed mushrooms to the spinach. Add ricotta and grated cheese to the bowl and the nutmeg. Stir to combine the stuffing. Return your skillet to the stove over medium high heat.\nPlace a mound of stuffing on each breast and wrap and roll breast over the stuffing. Secure breasts with toothpicks. Add 3 tablespoons oil to the pan, 3 turns of the pan. Add breasts to the pan and brown on all sides, cooking chicken 10 to 12 minutes. The meat will cook quickly because it is thin. Remove breasts; add butter to the pan and flour. Cook butter and flour for a minute, whisk in wine and reduce another minute. Whisk in broth and return breasts to the pan. Reduce heat and simmer until ready to serve. Remove toothpicks. Serve breasts whole or, remove from pan, slice on an angle and fan out on dinner plates. Top stuffed chicken breasts or sliced stuffed breasts with generous spoonfuls of the sauce."
    end

    its(:name) { should == "Spinach and Mushroom Stuffed Chicken Breasts" }
    its(:prep_time) { should == nil }
    its(:published_date) { should == Date.new(2015, 5, 16) }
    its(:total_time) { should == 35 }
    its(:yield) { should == "4 servings" }

    it 'should parse the name of a schema.org Person when they are the author' do
      expect(subject.author).to eq('Rachael Ray : Food Network')
    end
  end
end
