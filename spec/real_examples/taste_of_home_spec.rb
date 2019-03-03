# encoding: UTF-8

describe Hangry do
  context "tasteofhome.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/tasteofhome.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:author) { should == "Taste of Home" }
    its(:canonical_url) { should == 'https://www.tasteofhome.com/recipes/rhubarb-popover-pie/' }
    its(:cook_time) { should == 20 }
    its(:description) { should == 'This fabulous spring breakfast "pie" is also delicious when pineapple or even fresh strawberries are mixed in with the rhubarb filling. Yum!&mdash;Patricia Kile, Elizabethtown, Pennsylvania.' }
    its(:image_url) { should == 'https://tmbidigitalassetsazure.blob.core.windows.net/secure/RMS/attachments/37/1200x1200/Rhubarb-Popover-Pie_exps49051_HCA1864839B02_17_3bC_RMS.jpg' }
    its(:ingredients) {
      should == [
        "1/2 cup all-purpose flour",
        "1/4 teaspoon salt",
        "2 large eggs",
        "1/2 cup 2% milk",
        "2 tablespoons butter",
        "FILLING:",
        "1-1/2 cups sliced fresh or frozen rhubarb, thawed",
        "1/2 cup canned pineapple chunks",
        "1/3 cup butter, cubed",
        "1/2 cup packed brown sugar",
        "Whipped cream or vanilla ice cream, optional"
      ]
    }
    its(:name) { should == "Rhubarb Popover Pie" }
    its(:nutrition) do
      should == {
        calories: "279 calories",
        cholesterol: '109mg cholesterol',
        fiber: "1g fiber)",
        protein: "4g protein.",
        saturated_fat: nil,
        sodium: "239mg sodium",
        sugar: nil,
        total_carbohydrates: "31g carbohydrate (21g sugars",
        total_fat: "16g fat (10g saturated fat)",
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      should == "In a large bowl, combine flour and salt. In another bowl, whisk eggs and milk., Place butter in an 9-in. pie plate; heat in a 425&deg; oven for 3-5 minutes or until butter is melted. Meanwhile, stir egg mixture into dry ingredients just until moistened., Carefully swirl the butter in the pan to coat the sides and bottom of pan; add batter. Bake at 425&deg; for 16-20 minutes or until puffed and golden brown., Meanwhile, in a large skillet, saute rhubarb and pineapple in butter until rhubarb is tender. Stir in brown sugar; bring to a boil over medium heat, stirring constantly. Pour into the center of puffed pancake; cut into six wedges. Serve immediately with whipped cream if desired."
    }

    its(:prep_time) { should == 25 }
    its(:published_date) { should == nil }
    its(:total_time) { should == 45 }
    its(:yield) { should == "6 servings." }
  end
end
