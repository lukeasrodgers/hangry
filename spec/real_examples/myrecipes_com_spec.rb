# encoding: utf-8

describe Hangry do

  context "myrecipes.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/myrecipes.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the schema.org parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::SchemaOrgRecipeParser)
    end

    its(:author) { should == "MyRecipes" }
    its(:canonical_url) { should == 'http://www.myrecipes.com/recipe/best-carrot-cake' }
    its(:cook_time) { should == nil }
    its(:description) { should == "" } # not valid HTML to have a p inside of an h2...
    its(:image_url) { should == "http://cdn-image.myrecipes.com/sites/default/files/styles/4_3_horizontal_-_1200x900/public/best-carrot-cake-sl.jpg?itok=tJtyQRp0" }
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
        "Buttermilk Glaze",
        "Cream Cheese Frosting"
      ]
    }
    its(:instructions) do
      instructions = <<-eos
      Step 1
Line 3 (9-inch) round cakepans with wax paper; lightly grease and flour wax paper. Set pans aside.
Step 2
Stir together first 4 ingredients.
Step 3
Beat eggs and next 4 ingredients at medium speed with an electric mixer until smooth. Add flour mixture, beating at low speed until blended. Fold in carrot and next 3 ingredients. Pour batter into prepared cakepans.
Step 4
Bake at 350° for 25 to 30 minutes or until a wooden pick inserted in center comes out clean. Drizzle Buttermilk Glaze evenly over layers; cool in pans on wire racks 15 minutes. Remove from pans, and cool completely on wire racks. Spread Cream Cheese Frosting between layers and on top and sides of cake.
      eos
      should == instructions.strip
    end
    it "should have nil nutrition attributes" do
      subject.nutrition.each do |attribute, value|
        expect(value).to be_nil
      end
    end
    its(:name) { should == "Recipes" } # Best Carrot Cake
    its(:prep_time) { should == nil }
    its(:published_date) { should == Date.new(1998, 12, 9) }
    its(:total_time) { should == nil }
    its(:yield) { should == "1 (9-inch) cake" }

  end

end
