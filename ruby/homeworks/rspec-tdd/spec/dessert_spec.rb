require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double('chef') }
  subject(:dessert) { Dessert.new('Ispahan', 20, chef) }

  describe '#initialize' do
    it 'sets a type' do
      expect(dessert.type).to eq('Ispahan')
    end

    it 'sets a quantity' do
      expect(dessert.quantity).to eq(20)
    end

    it 'starts ingredients as an empty array' do
      expect(dessert.ingredients).to be_empty
    end

    it 'raises an argument error when given a non-integer quantity' do
      expect { Dessert.new('Ispahan', 'loads', chef) }.to raise_error(ArgumentError)
    end
  end

  describe '#add_ingredient' do
    it 'adds an ingredient to the ingredients array' do
      dessert.add_ingredient('rose')
      expect(dessert.ingredients).to include('rose')
    end
  end

  describe '#mix!' do
    it 'shuffles the ingredient array' do
      ingredients = %w[rose lychee raspberry sugar]
      ingredients.each { |ingredient| dessert.add_ingredient(ingredient) }

      expect(dessert.ingredients).to eq(ingredients)

      dessert.mix!

      expect(dessert.ingredients).not_to eq(ingredients)
      expect(dessert.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe '#eat' do
    it 'subtracts an amount from the quantity' do
      dessert.eat(5)
      expect(dessert.quantity).to eq(15)
    end

    it 'raises an error if the amount is greater than the quantity' do
      expect { dessert.eat(450) }.to raise_error('not enough left!')
    end
  end

  describe '#serve' do
    it "contains the titleized version of the chef's name" do
      # adding a method to the chef mock/double
      allow(chef).to receive(:titleize).and_return('Pierre Hermé the Great Baker')
      expect(dessert.serve).to eq('Pierre Hermé the Great Baker has made 20 Ispahans!')
    end
  end

  describe '#make_more' do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
