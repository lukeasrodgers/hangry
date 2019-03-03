# encoding: UTF-8

describe Hangry do
  context "rachaelray.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/www.rachaelray.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use a non-standard parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::Parsers::NonStandard::RachaelRayParser)
    end

    its(:author) { should == "Rachael Ray" }
    its(:canonical_url) { should == "https://www.rachaelray.com/recipes/quick-chick-and-noodle-soup/" }
    its(:cook_time) { should == nil }
    its(:description) { should == "This hearty recipes yields 2 quarts of soup – that’s 4 big bowls! Parsnips, which look like white carrots, but taste like sweet turnips or spicy potatoes, are best when cooked until soft to bring out their natural mellow sweetness." }
    its(:image_url) { should == nil }
    its(:ingredients) {
      should == [
        '2 tablespoons extra virgin olive oil (EVOO)',
        '2 medium carrots, peeled and chopped',
        '1 parsnip, peeled and chopped',
        '1 medium onion, chopped',
        '2 ribs celery, chopped',
        '2 bay leaves, fresh or dried',
        'Salt and pepper',
        '6 cups good quality chicken stock',
        '1 pound (the average weight of 1 package) chicken breast tenders, diced',
        '1/2 pound wide egg noodles',
        'A handful fresh parsley, chopped',
        'A handful fresh dill, chopped'
      ]
    }
    its(:name) { should == "Quick Chick and Noodle Soup - Rachael Ray" }
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
      should == "Place a large\npot\nover moderate heat and add extra virgin olive oil, 2 turns around the\npan\n. Work close to the stove and add vegetables to the\npot\nas you chop, in the order they are listed.\nAdd bay leaves and season vegetables with salt and pepper, to taste. Add stock to the pot and raise flame to bring liquid to a boil. Add diced chicken tenderloins, return soup to a boil, and reduce heat back to moderate. Cook chicken 2 minutes and add noodles. Cook soup an additional 6 minutes or until noodles are tender and remove soup from the heat.\nStir in parsley and dill, remove bay leaves and serve. This is a thick soup. Add up to 2 cups of water if you like chicken soup with lots of broth."
    }

    its(:prep_time) { should == nil }
    its(:published_date) { should == nil }
    its(:total_time) { should == nil }
    its(:yield) { should == nil }
  end
end
