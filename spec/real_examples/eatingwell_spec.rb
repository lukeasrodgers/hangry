# encoding: UTF-8

describe Hangry do
  context "eatingwell.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/www.eatingwell.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use a non-standard parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::Parsers::NonStandard::EatingWellParser)
    end

    its(:author) { should == "EatingWell Test Kitchen" }
    its(:canonical_url) { should == "http://www.eatingwell.com/recipe/251798/sauteed-chicken-breasts-with-creamy-chive-sauce/" }
    its(:cook_time) { should == 35 }
    its(:description) { should == "This quick chicken recipe is low in calories thanks to a few healthy cooking tech" }
    its(:image_url) { should == "https://cf-images.us-east-1.prod.boltdns.net/v1/static/5118192885001/70354b55-2ee5-4dc6-afbc-bccf64994807/cd57020e-fce2-478a-9836-6ff2c803e5df/465x310/match/image.jpg" }
    its(:ingredients) {
      should == [
        "4 boneless, skinless chicken breasts, (about 1 pound), trimmed of fat",
        "1 teaspoon kosher salt, divided", "¼ cup plus 1 tablespoon all-purpose flour, divided",
        "3 teaspoons extra-virgin olive oil, divided", "2 large shallots, finely chopped",
        "½ cup dry white wine", "1 14-ounce can reduced-sodium chicken broth", "⅓ cup reduced-fat sour cream",
        "1 tablespoon Dijon mustard", "½ cup chopped chives, (about 1 bunch)"
      ]
    }
    its(:name) { should == "Healthy Dinner: Chicken with Creamy Chive Sauce Recipe" }
    its(:nutrition) do
      should == {
        calories: '257 calories;',
        cholesterol: '70',
        fiber: '0',
        protein: '26',
        saturated_fat: '3',
        sodium: '634',
        sugar: '1',
        total_carbohydrates: '12',
        total_fat: '9',
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
Place chicken between sheets of plastic wrap and pound with a meat mallet or heavy skillet until flattened to an even thickness, about ½ inch. Season both sides of the chicken with ½ teaspoon salt. Place ¼ cup flour in a shallow glass baking dish and dredge the chicken in it. Discard the excess flour.
Heat 2 teaspoons oil in a large nonstick skillet over medium-high heat. Add the chicken and cook until golden brown, 1 to 2 minutes per side. Transfer to a plate, cover and keep warm.
Heat the remaining 1 teaspoon oil in the pan over medium-high heat. Add shallots and cook, stirring constantly and scraping up any browned bits, until golden brown, 1 to 2 minutes. Sprinkle with the remaining 1 tablespoon flour; stir to coat. Add wine, broth and the remaining ½ teaspoon salt; bring to a boil, stirring often.
Return the chicken and any accumulated juices to the pan, reduce heat to a simmer, and cook until heated through and no longer pink in the center, about 6 minutes. Stir in sour cream and mustard until smooth; turn the chicken to coat with the sauce. Stir in chives and serve immediately.
      EOS
      should == instructions.strip
    }

    its(:prep_time) { should == nil }
    its(:published_date) { should == nil }
    its(:total_time) { should == 35 }
    its(:yield) { should == "4" }
  end
end
