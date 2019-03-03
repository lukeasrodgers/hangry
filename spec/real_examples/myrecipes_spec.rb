# encoding: utf-8

describe Hangry do
  context "myrecipes.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/www.myrecipes.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:author) { should == "MyRecipes" }
    its(:canonical_url) { should == 'https://www.myrecipes.com/recipe/best-carrot-cake' }
    its(:cook_time) { should == nil }
    its(:description) { should == "Truly our best-ever carrot cake recipe, make this classic favorite for a crowd and you might not have any leftovers to bring home. For more flavor, try toasting the nuts and coconut before adding them to the batter. It's important to cool the cakes completely before frosting, otherwise the frosting will just melt right off. To expediate the cooling process, you can put the cakes on their wire racks in the freezer (don't worry, it's not cheating), checking until they're thoroughly cool. This is a cake you can bake for any occasion. We recommend this cake anytime from Easter to Christmas." }
    its(:image_url) { should == "https://cdn-image.myrecipes.com/sites/default/files/styles/4_3_horizontal_-_1200x900/public/best-carrot-cake-sl.jpg?itok=YApFC-i_" }
    its(:ingredients) {
      should == [
        "2 cups all-purpose flour",
        "2 teaspoons baking soda",
        "1/2 teaspoon salt",
        "2 teaspoons ground cinnamon",
        "3 large eggs",
        "2 cups sugar",
        "3/4 cup vegetable oil",
        "3/4 cup buttermilk",
        "2 teaspoons vanilla extract",
        "2 cups grated carrot",
        "1 (8-ounce) can crushed pineapple, drained",
        "1 (3 1/2-ounce) can flaked coconut",
        "1 cup chopped pecans or walnuts",
        "<a href=\"https://www.myrecipes.com/recipe/buttermilk-glaze-2\"> Buttermilk Glaze</a>",
        "<a href=\"https://www.myrecipes.com/recipe/cream-cheese-frosting-43\"> Cream Cheese Frosting</a>"
      ]
    }
    its(:instructions) do
      should == "Line 3 (9-inch) round cakepans with wax paper; lightly grease and flour wax paper. Set pans aside. Stir together first 4 ingredients. Beat eggs and next 4 ingredients at medium speed with an electric mixer until smooth. Add flour mixture, beating at low speed until blended. Fold in carrot and next 3 ingredients. Pour batter into prepared cakepans. Bake at 350° for 25 to 30 minutes or until a wooden pick inserted in center comes out clean. Drizzle Buttermilk Glaze evenly over layers; cool in pans on wire racks 15 minutes. Remove from pans, and cool completely on wire racks. Spread Cream Cheese Frosting between layers and on top and sides of cake."
    end
    it "should have nil nutrition attributes" do
      subject.nutrition.each do |attribute, value|
        expect(value).to be_nil
      end
    end
    its(:name) { should == "Best Carrot Cake" }
    its(:prep_time) { should == nil }
    its(:published_date) { should == Date.new(1998, 12, 9) }
    its(:total_time) { should == nil }
    its(:yield) { should == "1 (9-inch) cake" }
  end
end
