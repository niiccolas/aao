require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include SlidingPiece

  def symbol
    color == :white ? '♗' : '♝'
  end

  protected

  def move_dirs
    DIAGONAL_DIR
  end
end
