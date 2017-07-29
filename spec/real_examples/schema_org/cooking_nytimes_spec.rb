# encoding: UTF-8

describe Hangry do
  context "cooking.nytimes.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/schema_org/cooking.nytimes.com.html")
      @parsed = Hangry.parse(@html)
    end

    subject { @parsed }

    it "should use a non-standard parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::Parsers::NonStandard::NyTimesParser)
    end

    its(:author) { should == "Nigella Lawson" }
    its(:canonical_url) { should == "http://cooking.nytimes.com/recipes/1017945-coq-au-riesling" }
    its(:cook_time) { should == nil }
    its(:description) { should == "The chicken stew here does have an authentic origin, but I have lightened it a little by dispensing with the cream that would be added luxuriously in its country of origin. And you can cheerfully use a dry or semi-dry from anywhere in the world. I have nothing against the regular coq au vin, but I might actually prefer this sprightlier version. It's certainly easier to make: in place of all those whole baby onions, which have to be peeled one by one, you can just chop your onions the usual and considerably less bothersome way. And since I always think that the breast meat of a chicken can be a bit stringy when cooked for a long time, I instead choose thigh portions. So no dismembering of a carcass is required either. Featured in: At My Table; Simply French: Comfort Food With Style. " }
    its(:prep_time) { should == nil }
    its(:total_time) { should == nil }
    its(:image_url) { should == 'https://static01.nyt.com/images/2016/01/23/dining/23COOKING_COQAURIESLING1/23COOKING_COQAURIESLING1-articleLarge.jpg' }
    its(:ingredients) {
      should == [
        "8 ounces sliced bacon, sliced crosswise into 1-inch pieces",
        "3 medium onions, peeled and roughly chopped",
        "10 chicken thighs, with skin and bone",
        "8 ounces button mushrooms, halved",
        "2 or 3 garlic cloves, peeled and minced",
        "¼ cup chopped Italian parsley",
        "3 tablespoons chopped tarragon",
        "1 bottle dry or off-dry riesling wine (750 ml)"
      ]
    }

    its(:instructions) do
      instructions = <<-eos
Place large flameproof casserole or other heavy-bottomed pan over medium heat. Add bacon, and cook until most of the fat has been rendered. Add onions and sauté until softened, about 10 minutes. Using a slotted spoon, transfer mixture to plate, leaving behind as much liquid fat as possible.
Place pan over medium-high heat. Working in batches (do not overcrowd pan), brown chicken pieces on both sides, transferring them to a plate after they are browned.
Reduce heat to medium-low. Add mushrooms, garlic, 3 tablespoons of parsley and 2 tablespoons of tarragon. Sauté until mushrooms are coated in fat, about 1 minute. Return chicken pieces, onions and bacon to pan. Add wine, and raise heat to bring to a boil. Partially cover, turn heat to low, and simmer for 1 hour.
To serve immediately, sprinkle with remaining parsley and tarragon. For best results, cool, and refrigerate overnight. The next day remove any chilled fat on surface with paper towels. Reheat gently, sprinkle with parsley and tarragon, and serve.
      eos
      should == instructions.strip
    end

    its(:name) { should == "Coq au Riesling" }
    its(:published_date) { should == nil }
    its(:yield) { should == "4 to 6 servings" }
  end
end
