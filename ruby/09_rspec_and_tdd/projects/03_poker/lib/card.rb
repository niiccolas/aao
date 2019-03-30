class Card
  FACES = %i[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :suit, :face, :rank

  def initialize(suit, face)
    @face     = face
    @suit     = suit
    @revealed = false
    rank_card
  end

  def revealed?
    @revealed
  end

  def reveal!
    @revealed = true
  end

  private

  def rank_card
    @rank = FACES.index(face) + 2
  end
end
