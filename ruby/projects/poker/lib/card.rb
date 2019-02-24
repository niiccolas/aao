class Card
  attr_reader :suit, :face, :rank

  def initialize(suit, face, rank)
    @rank     = rank
    @face     = face
    @suit     = suit
    @revealed = false
  end

  def revealed?
    @revealed
  end

  def reveal!
    @revealed = true
  end
end
