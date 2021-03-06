require_relative 'piece'
require_relative 'sliding_piece'

class Rook < Piece
  include SlidingPiece

  def symbol
    color == :white ? '♖' : '♜'
  end

  protected

  def move_dirs
    PERPENDICULAR_DIR
  end
end
