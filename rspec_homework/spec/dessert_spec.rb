require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", :titleize => "Chef", :bake => "baked") }
  subject(:dessert) { Dessert.new("hot dog", 50, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq "hot dog"
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq 50
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq []
    end

    context "errors raised" do
      let(:dessert) { Dessert.new("hot dogs", "five", chef) }
      it "raises an argument error when given a non-integer quantity" do
        expect { dessert }.to raise_error(ArgumentError)
      end  
    end
    
  end

  describe "#add_ingredient" do
    before(:example) do
      dessert.add_ingredient("scobies")
    end
    it "adds an ingredient to the ingredients array" do
      expect(dessert.ingredients).to eq ["scobies"]
    end
  end


  describe "#mix!" do
    before(:example) do
      dessert.add_ingredient("1")
      dessert.add_ingredient("2")
      dessert.add_ingredient("3")
      dessert.mix!
    end
    it "shuffles the ingredient array" do
      expect(dessert.ingredients).to_not eq %q(1 2 3)
    end
  end


  describe "#eat" do
    before(:example) do
      dessert.eat(50)
    end
    
    it "subtracts an amount from the quantity" do
      expect(dessert.quantity).to eq 0
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(1) }.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(dessert.serve).to eq "Chef has made 50 hot dogs!"
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
