# encoding: UTF-8

describe Hangry do

  context "taste.com.au recipe" do
    before(:all) do
      @html =File.read("spec/fixtures/taste.com.au.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the ld+json parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::JsonLDParser)
    end

    its(:author) { should == "Sophia Young" }
    its(:canonical_url) { should == 'http://www.taste.com.au/recipes/lemon-melting-moments/e5384539-ac49-4852-939d-1c44a4917674' }
    its(:cook_time) { should == 15 }
    its(:description) { should == "Take a trip down memory lane with these buttery biccies. They're great for teatime or with coffee for your next dinner party." }
    its(:image_url) { should == 'http://img.taste.com.au/y8u5JWmh/taste/2016/11/lemon-melting-moments-79344-1.jpeg' }
    its(:ingredients) { should == [
      '200g (1 1/3 cups) plain flour',
      '100g (2/3 cup) cornflour',
      '225g unsalted butter, chopped, softened',
      '80g (1/2 cup) icing sugar, sifted, plus extra, to dust',
      '3 lemons, zested',
      '1 teaspoon vanilla extract',
      '4 passionfruit, pulp removed',
      '200g (1 1/4 cups) icing sugar, sifted',
      '1 tablespoon liquid glucose',
      '80g unsalted butter, softened'
    ] }
    its(:name) { should == "Lemon melting moments" }
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

    its(:instructions) { should == "1 Preheat oven to 170C. Sift flours with 1/4 teaspoon salt into a bowl. Using an electric mixer, beat butter and sugar until pale and fluffy. Add zest and vanilla, then gradually beat in combined flours until mixture just comes together.\nRoll 2 teaspoonsful of dough into balls, placing them on 2 oven trays lined with baking paper. Using a floured flat bottom of a glass, flatten balls to 3.5cm rounds, then, using the back of a floured fork, mark biscuits with tines. Bake for 12 minutes, swapping trays halfway, or until biscuits are light golden. Transfer to a wire rack to cool. Makes 40.\nMeanwhile, to make filling, press pulp through a fine sieve, reserving seeds. Place 2 tablespoons juice, 3 teaspoons reserved seeds and remaining ingredients in the bowl of an electric mixer. Beat on high speed until fluffy. Refrigerate for 30 minutes.\nSpread filling on 20 biscuits, then sandwich with remaining biscuits. Dust with extra icing sugar to serve." }
    its(:prep_time) { should == 30 }
    its(:published_date) { should == Date.new(2010, 8, 18) }
    its(:total_time) { should == 45 }
    its(:yield) { should == 0 }

  end

end
