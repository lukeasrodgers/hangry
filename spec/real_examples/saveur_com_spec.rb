# encoding: UTF-8

describe Hangry do
  context "saveur.com recipe" do
    before(:all) do
      skip "saveur.com appears to be using schema.org / RDFa format which will call for a new parser"
      @html = File.read("spec/fixtures/saveur.com.html")
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the data-vocabulary parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::DataVocabularyRecipeParser)
    end

    its(:author) { should == nil }
    its(:canonical_url) { should == "http://www.saveur.com/article/Recipes/Smoked-Trout-Blinis-with-Creme-Fraiche-and-Dill" }
    its(:cook_time) { should == nil }
    its(:description) { should == "Sweet and supple miniature pancakes are topped with flakes of tender smoked trout and sprinkled with cayenne pepper for a touch of invigorating heat. A dollop of cr�me fra�che and a touch of anisey dill balance the fish's smoky intensity." }
    its(:image_url) { should == "http://www2.worldpub.net/images/saveurmag/7-Gallery-One-Bite-Trout-Belinis-500x750.jpg" }
    its(:ingredients) { should == [] }
    its(:name) { should == "Smoked Trout Blinis with Crème Fraîche and Dill" }
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

    its(:instructions) { should == nil }
    its(:prep_time) { should == nil }
    its(:published_date) { should == Date.new(2013, 3, 12) }
    its(:total_time) { should == nil }
    its(:yield) { should == nil }
  end
end
