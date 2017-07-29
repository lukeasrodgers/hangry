# encoding: UTF-8

describe Hangry do

  context "thespruce.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/thespruce.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:author) { should == "Peggy Trowbridge Filippone" }
    its(:canonical_url) { should == "https://www.thespruce.com/white-chocolate-key-lime-muffins-recipe-1808282" }
    its(:cook_time) { should == 25 }
    its(:description) { should == "Use this basic recipe for incredibly moist and delightfully tangy sweet muffins or cake." }
    its(:image_url) { should == "https://fthmb.tqn.com/jf7bsf8q5MMsyLL-zuStP1EB5-E=/1600x1200/filters:no_upscale()/about/blmuff23-56a4957e3df78cf772831d0f.jpg" }
    its(:ingredients) {
      should == [
        "<strong>Cupcakes/Cake:<\/strong>",
        "1-3/4 cups all-purpose flour",
        "2 teaspoons <strong><a href=\"https://www.thespruce.com/leavening-what-is-baking-powder-1809259\" zT=\"-o1/XJ\" target=\"_blank\">baking powder<\/a><\/strong>",
        "1/2 teaspoon salt",
        "6 Tablespoons butter, softened",
        "1 cup sugar",
        "2 large eggs, lightly beaten",
        "1-1/2 teaspoons grated key lime zest",
        "1 Tablespoon fresh <strong><a href=\"https://www.thespruce.com/what-are-key-limes-1807847\" zT=\"-o1/XJ\" target=\"_blank\">key lime<\/a><\/strong> juice",
        "2/3 cup <strong><a href=\"https://www.thespruce.com/what-is-buttermilk-1806998\" zT=\"-o1/XJ\" target=\"_blank\">buttermilk<\/a><\/strong>",
        "<strong>Glaze:<\/strong>",
        "1 cup powdered sugar",
        "1/8 cup fresh key lime juice"
      ]
    }
    its(:name) { should == "White Chocolate Key Lime Muffins or Cake Recipe" }
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
      should == "&lt;h3&gt;For Muffins:&lt;/h3&gt;&lt;p&gt;Preheat oven to 350 degrees F (175 degrees C). Line standard-size muffin tin with foil liners.&lt;br/&gt;&lt;br/&gt;Blend the flour, baking powder, and salt together in a small bowl. Set aside.&lt;br/&gt;&lt;br/&gt;In a large mixing bowl, cream butter and sugar together with a mixer, beating until blended. Add the eggs, 1-1/2 teaspoons lime zest, and 1 tablespoon lime juice.&lt;br/&gt;&lt;br/&gt;Into the butter-cream mixture in the large bowl, add 1/3 of the flour mixture, stirring until combined. Add one-third of the buttermilk, stirring until combined. Continue alternating one-third of each until all is mixed well. Fold in white chocolate chips.&lt;br/&gt;&lt;br/&gt;Fill cupcake liners two-thirds full with batter. Bake 18 to 20 minutes (or 12 to 14 minutes for mini-muffins) until wooden pick inserted in the center comes out clean.&lt;br/&gt; &lt;/p&gt;&lt;h3&gt;Glaze:&lt;/h3&gt;&lt;p&gt;Whisk powdered sugar and 1/8 cup lime juice together until combined and smooth. While muffins are still warm, poke holes in the tops of the muffins with a wooden pick. Smooth about a teaspoon on top of each warm muffin. Cool completely.&lt;br/&gt;&lt;br/&gt;Yield: about 18 muffins&lt;/p&gt;&lt;h3&gt;For Cake:&lt;/h3&gt;&lt;p&gt;&lt;br/&gt;Preheat oven to 350 degrees F (175 degrees C). Prepare 9 x 13-inch baking pan by lining with foil (non-stick foil recommended).&lt;br/&gt;&lt;br/&gt;Follow the same mixing instructions as above. Spread batter evenly in pan. Bake 35 to 40 minutes or until wooden pick inserted in center comes out clean. Let rest in pan about 5 minutes and then poke holes all over the top of the cake with a wooden pick. Spread glaze evenly over top of cake and cool completely. Cut into 18 pieces to serve.&lt;br/&gt;&lt;br/&gt;Yield: 18 servings&lt;/p&gt;"
    }

    its(:prep_time) { should == 10 }
    its(:published_date) { should == Date.parse('2008-03-10T09:09:57.000Z') }
    its(:total_time) { should == 35 }
    its(:yield) { should == '18 muffins/18 servings' }

  end

end
