require 'deck'

describe 'Deck' do
  subject { Deck.new }
  let(:deck) { subject.deck }

  it 'creates a 52 cards deck' do
    expect(subject.deck.size).to eq(52)
  end

  it 'creates four suits of 13 cards each' do
    suits = {
      diamonds: deck.select { |x| x.suit == :diamonds },
      clubs: deck.select { |x| x.suit == :clubs },
      hearts: deck.select { |x| x.suit == :hearts },
      spades: deck.select { |x| x.suit == :spades }
    }

    suits.each_value do |val|
      expect(val.size).to eq(13)
    end
  end

  it 'does not allow modification of the deck' do
    expect { subject.deck = 'reckless change' }.to raise_error(NoMethodError)
  end

  describe '#shuffle' do
    it 'shuffles the deck' do
      mint_deck = Deck.new
      subject.shuffle!
      expect(mint_deck.deck).not_to eq(subject.deck)
    end
  end

  describe '#take_cards(n)' do
    it 'takes `n` cards from the deck' do
      n_cards_out = 5

      subject.take_cards(n_cards_out)
      expect(deck.size).to eq(52 - n_cards_out)

      subject.take_cards(7)
      expect(deck.size).to eq(40)
    end

    it 'is limited by the number of cards remaining in the deck' do
      expect { Deck.new.take_cards(67) }.to raise_error('Not enough cards')

      expect { Deck.new.take_cards(152) }.to raise_error('Not enough cards')
    end
  end
end
