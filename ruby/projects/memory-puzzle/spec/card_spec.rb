require 'card'

describe Card do
  describe '::shuffled_pairs' do
    context "Given an integer representing cards pairs" do
      it 'should return an array' do
        expect(Card.shuffled_pairs(4).is_a? Array).to eq(true)
      end

      it 'should should contain Card objects only' do
        expect(Card.shuffled_pairs(4).all? { |card| card.is_a? Card}).to eq(true)
      end

      pairs = 4
      it 'should return an array double the size of given pairs' do
        expect(Card.shuffled_pairs(pairs).length).to eq(pairs * 2)
      end

      it 'should raise an error if given an integer greater than 26' do
        expect { Card.shuffled_pairs(44) }.to raise_error(ArgumentError)
      end

      it 'should raise an error if given an odd integer' do
        expect { Card.shuffled_pairs(3) }.to raise_error(ArgumentError)
      end
    end

    pairs = Card.shuffled_pairs(2)
    describe '#reveal' do
      it 'should should set @face_up of a card to true' do
        pairs[0].reveal
        expect(pairs[0].revealed?).to eq(true)
      end
    end

    describe '#hide' do
      it 'should should set the @face_up of a card to false' do
        pairs[0].hide
        expect(pairs[0].revealed?).to eq(false)
      end
    end

    describe '#revealed?' do
      it 'should return the value of @face_up (by default false)' do
        expect(Card.shuffled_pairs(2)[0].instance_variable_get(:@face_up)).to eq(false)
      end
    end

    describe '#==' do
      pairs[0].instance_variable_set(:@value, 'W')
      pairs[1].instance_variable_set(:@value, 'W')

      it 'should return true when two cards have the same value' do
        expect(pairs[0] == pairs[1]).to eq(true)
      end

      pairs[2].instance_variable_set(:@value, 'A')
      it 'should return false when two cards differ' do
        expect(pairs[0] == pairs[2]).to eq(false)
      end
    end
  end
end
