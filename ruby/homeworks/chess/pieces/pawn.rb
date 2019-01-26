require_relative 'piece'

class Pawn < Piece
  def symbol
    color == :white ? '♙' : '♟'
  end

  def move_dirs
    [
      [1,  0],
      [2,  0],
      [1, -1],
      [1,  1]
    ]
  end

  private

  def at_start_row?
    row = pos[0]
    [1, 6].include? row
  end
end
