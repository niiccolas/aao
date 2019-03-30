require 'hand'
require 'card'

describe Hand do
  HELPER_HANDS = {
    royal_straight_flush: [
      Card.new(:hearts, :'10'),
      Card.new(:hearts, :J),
      Card.new(:hearts, :Q),
      Card.new(:hearts, :K),
      Card.new(:hearts, :A)
    ],
    straight_flush: [
      Card.new(:hearts, :'9'),
      Card.new(:hearts, :'10'),
      Card.new(:hearts, :J),
      Card.new(:hearts, :Q),
      Card.new(:hearts, :K)
    ],
    four_of_a_kind: [
      Card.new(:hearts, :J),
      Card.new(:clubs, :J),
      Card.new(:diamonds, :J),
      Card.new(:spades, :J),
      Card.new(:hearts, :A)
    ],
    full_house: [
      Card.new(:hearts, :K),
      Card.new(:spades, :K),
      Card.new(:clubs, :J),
      Card.new(:diamonds, :J),
      Card.new(:spades, :J)
    ],
    full_house_weaker: [
      Card.new(:hearts, :'7'),
      Card.new(:spades, :K),
      Card.new(:clubs, :J),
      Card.new(:diamonds, :J),
      Card.new(:spades, :J)
    ],
    flush: [
      Card.new(:hearts, :K),
      Card.new(:hearts, :J),
      Card.new(:hearts, :'8'),
      Card.new(:hearts, :'5'),
      Card.new(:hearts, :'3')
    ],
    straight: [
      Card.new(:spades, :'2'),
      Card.new(:diamonds, :'3'),
      Card.new(:hearts, :'4'),
      Card.new(:clubs, :'5'),
      Card.new(:hearts, :'6')
    ],
    three_of_a_kind: [
      Card.new(:hearts, :J),
      Card.new(:clubs, :J),
      Card.new(:diamonds, :J),
      Card.new(:spades, :'2'),
      Card.new(:hearts, :K)
    ],
    two_pair: [
      Card.new(:hearts, :'6'),
      Card.new(:clubs, :'6'),
      Card.new(:spades, :'7'),
      Card.new(:spades, :'7'),
      Card.new(:hearts, :'2')
    ],
    pair: [
      Card.new(:hearts, :'6'),
      Card.new(:clubs, :J),
      Card.new(:spades, :'7'),
      Card.new(:spades, :'7'),
      Card.new(:hearts, :'2')
    ],
    pair_24pts: [
      Card.new(:hearts, :'6'),
      Card.new(:hearts, :'6'),
      Card.new(:spades, :'7'),
      Card.new(:spades, :'3'),
      Card.new(:hearts, :'2')
    ],
    pair_40pts: [
      Card.new(:hearts, :A),
      Card.new(:hearts, :A),
      Card.new(:spades, :'2'),
      Card.new(:spades, :'6'),
      Card.new(:hearts, :'4')
    ],
    high_card: [
      Card.new(:hearts, :'6'),
      Card.new(:clubs, :J),
      Card.new(:spades, :'7'),
      Card.new(:spades, :'4'),
      Card.new(:hearts, :'2')
    ]
  }

  describe 'Evaluating hands' do
    HELPER_HANDS.keys.each do |hand|
      let(hand) { Hand.new(HELPER_HANDS[hand]) }
    end

    it 'it is composed of 5 cards' do
      expect(two_pair.hand.length).to eq(5)
    end

    it 'is made of Cards objects only' do
      two_pair.hand.each do |card|
        expect(card).to be_an_instance_of(Card)
      end
    end

    context '#high_card?' do
      it 'returns true when hand has nothing but a High card' do
        expect(high_card.high_card?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.pair?).to be false
        expect(high_card.two_pair?).to be false
        expect(high_card.three_of_a_kind?).to be false
      end
    end

    context '#pair?' do
      it 'returns true when hand has one' do
        expect(pair.pair?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.pair?).to be false
      end
      it 'differentiates with #two_pairs?' do
        expect(two_pair.pair?).to be false
      end
    end

    context '#two_pair?' do
      it 'returns true when hand has one' do
        expect(two_pair.two_pair?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.two_pair?).to be false
      end
      it 'differentiates with #pair?' do
        expect(two_pair.pair?).to be false
      end
    end

    context '#three_of_a_kind?' do
      it 'returns true when hand has one' do
        expect(three_of_a_kind.three_of_a_kind?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.three_of_a_kind?).to be false
      end
      it 'differentiates with #four_of_a_kind?' do
        expect(three_of_a_kind.four_of_a_kind?).to be false
      end
    end

    context '#straight?' do
      it 'returns true when hand has one' do
        expect(straight.straight?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.straight?).to be false
      end
      it 'differentiates with #straight_flush?' do
        expect(straight.straight_flush?).to be false
      end
    end

    context '#flush?' do
      it 'returns true when hand has one' do
        expect(flush.flush?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.flush?).to be false
      end
    end

    context '#full_house?' do
      it 'returns true when hand has one' do
        expect(full_house.full_house?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.full_house?).to be false
      end
    end

    context '#four_of_a_kind?' do
      it 'returns true when hand has one' do
        expect(four_of_a_kind.four_of_a_kind?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.four_of_a_kind?).to be false
      end
      it 'differentiates with #three_of_a_kind?' do
        expect(four_of_a_kind.three_of_a_kind?).to be false
      end
    end

    context '#straight_flush?' do
      it 'returns true when hand has one' do
        expect(straight_flush.straight_flush?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.straight_flush?).to be false
      end
      it 'differentiates with #flush?' do
        expect(straight_flush.flush?).to be false
      end
    end

    context '#royal_straight_flush?' do
      it 'returns true when hand has one' do
        expect(royal_straight_flush.royal_straight_flush?).to be true
      end
      it 'returns false otherwise' do
        expect(high_card.royal_straight_flush?).to be false
      end
      it 'differentiates with #straight_flush?' do
        expect(royal_straight_flush.straight_flush?).to be false
      end
    end

    describe '#winning_hand?' do
      context 'when facing stronger hands' do
        it 'returns false' do
          expect(pair.winning_hand?(two_pair, flush)).to be false
          expect(straight.winning_hand?(full_house, four_of_a_kind, flush)).to be false
        end
      end

      context 'when facing weaker hands' do
        it 'returns true' do
          expect(straight_flush.winning_hand?(straight, flush)).to be true
          expect(three_of_a_kind.winning_hand?(two_pair, high_card, pair)).to be true
        end
      end

      context 'when there is a tie' do
        it 'compares kicker values to determine the winner' do
          expect(pair_40pts.winning_hand?(pair_24pts)).to be true
          expect(pair_40pts.winning_hand?(pair_24pts, high_card)).to be true
          expect(pair_24pts.winning_hand?(pair_40pts)).to be false
        end
      end
    end

    describe '#kicker_value' do
      it "returns the sum of each card's rank" do
        expect(pair_24pts.kicker_value).to eq(24)
        expect(pair_40pts.kicker_value).to eq(40)
      end
    end

    describe '#hand_value' do
      it 'ranks the lowest hand (High card) 1' do
        expect(high_card.hand_value).to eq(1)
      end

      it 'ranks the highest hand (Royal straight flush) 10' do
        expect(royal_straight_flush.hand_value).to eq(10)
      end

      it 'ranks a Straight 5' do
        expect(straight.hand_value).to eq(5)
      end

      it 'ranks a Pair lower than a Two pair' do
        expect(pair.hand_value).to be < two_pair.hand_value
      end
    end

    describe '#hand_name' do
      it 'returns a string' do
        expect(pair.hand_name).to be_an_instance_of String
      end

      it 'capitalizes the first letter' do
        expect(/[[:upper:]]/.match?(pair.hand_name[0])).to be true
      end

      it 'returns the name of the current hand' do
        expect(high_card.hand_name).to eq('High card')
        expect(two_pair.hand_name).to eq('Two pair')
        expect(royal_straight_flush.hand_name).to eq('Royal straight flush')
      end

      it 'removes underscores from the original symbols' do
        expect(royal_straight_flush.hand_name).not_to eq('Royal_straight_flush')
        expect(royal_straight_flush.hand_name).not_to eq(:royal_straight_flush)
      end
    end
  end
end
