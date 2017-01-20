# encoding: UTF-8

describe Hangry do

  context "mrfood.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/hrecipe/mrfood.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    its(:author) { should == 'rac7431 2877525' }
    its(:canonical_url) { should == "http://www.MrFood.com/Slow-Cooker-Recipes/Saucy-Italian-Pot-Roast-4268" }
    its(:cook_time) { should == 320 }
    its(:description) { should == "Try this saucy pot roast over egg noodles, rice, or-for more authentic Italian flavor-polenta. It's a winner whichever way you choose!" }
    its(:image_url) { should == "//irepo.primecp.com/2015/09/235934/Saucy-Italian-Pot-Roast_Large600_ID-1183018.jpg?v=1183018" }
    its(:ingredients) {
      should == [
        "1 (8-ounce) package sliced fresh baby Portobello mushrooms",
        "1 large onion, cut in half and sliced",
        "1 (2-1/2- to 3-pound boneless chuck roast, trimmed",
        "1 (1.6-ounce) package garlic-and-herb sauce mix",
        "1/2 teaspoon crushed red pepper",
        "2 (14-1/2-ounce) cans Italian-style diced tomatoes, undrained",
        "1 (8-ounce) can no-salt-added tomato sauce",
        "2 tablespoons cornstarch",
        "2 tablespoons water"
      ]
    }
    its(:name) { should == "Saucy Italian Pot Roast" }
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

    its(:instructions) { should == "Place mushrooms and onion in a 6-quart slow cooker; add roast. Sprinkle roast evenly with sauce mix and crushed red pepper. Pour diced tomatoes and tomato sauce over roast.Cover and cook on HIGH setting 5 to 6 hours or until meat is very tender. Remove roast from slow cooker, and cut into large chunks; keep warm.Skim fat from juices in slow cooker; discard fat. Stir together cornstarch and water in a small bowl until smooth; add to juices in slow cooker, stirring until blended.Cover and cook on HIGH setting 20 to 30 more minutes or until mixture is thickened, stirring once. Add roast pieces back to slow cooker. Cover and cook until thoroughly heated." }

    its(:prep_time) { should == nil }
    its(:published_date) { should == Date.parse('July 26, 2011') }
    its(:total_time) { should == nil }
    its(:yield) { should == "10" }

  end

end

