class Card
  attr_reader :suit, :face, :value

  def initialize(suit, face, value)
    @value    = value
    @face     = face
    @suit     = suit
    @revealed = false
  end

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
  end
end
