require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece

  def symbol
    color == :white ? '♕' : '♛'
  end

  protected

  def move_dirs
    HORIZONTAL_DIR + PERPENDICULAR_DIR
  end
end