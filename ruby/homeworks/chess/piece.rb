class Piece
  attr_reader :symbol
  def initialize
    @symbol = '♜'
  end
end

class NullPiece < Piece
  def initialize
    @symbol = '_'
  end
end