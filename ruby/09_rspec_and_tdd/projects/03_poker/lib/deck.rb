require_relative 'card'

class Deck
  SUITS = %i[diamonds clubs hearts spades].freeze
  FACES = %i[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_accessor :deck

  def initialize
    create_deck
    deck.shuffle!
  end

  def create_deck
    @deck = []
    SUITS.each do |suit|
      FACES.each { |face| deck << Card.new(suit, face) }
    end
  end

  def take_first_card
    deck.shift
  end

  def size
    deck.size
  end

  def shuffle!
    deck.shuffle!
  end
end
