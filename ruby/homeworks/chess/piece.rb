class Piece
  attr_reader :color, :board, :pos
  def initialize(color, board, position)
    @color = color
    @board = board
    @pos   = position
    # @symbol = '♜'
  end
end

module SlidingPiece
  def moves
    puts
    p self
    puts "From the SlidingPiece module:"
    self.move_dirs
  end

  private

  DIAGONAL_DIR = [[-1, -1], [-1, 1], [1, -1], [1, 1]].freeze
  HORIZONTAL_DIR = [[-1, 0], [1, 0], [0, -1], [0, 1]].freeze

  def diagonal_dir
    DIAGONAL_DIR
  end

  def horizontal_dir
    HORIZONTAL_DIR
  end
end

module SteppingPiece
  def moves
    puts
    puts "from SteppingPiece"
    self.move_diffs
  end
end

class Bishop < Piece
  include SlidingPiece

  def symbol
    color == :white ? '♗' : '♝'
  end

  protected

  def move_dirs
    DIAGONAL_DIR
    # diagonal_dir
  end
end


class Rook < Piece
  include SlidingPiece

  def symbol
    color == :white ? '♖' : '♜'
  end

  protected

  def move_dirs
    HORIZONTAL_DIR
  end
end


class Queen < Piece
  include SlidingPiece

  def symbol
    # color == :white ? "\u2656" : '♜'
    color == :white ? '♕' : '♛'
  end

  protected

  def move_dirs
    HORIZONTAL_DIR + DIAGONAL_DIR
  end
end

class Knight < Piece
  include SteppingPiece

  def symbol
    color == :white ? '♘' : '♞'
  end

  protected

  def move_diffs
    [
      [-1, -2], [-2, -1],
      [ 1, -2], [ 2, -1],
      [-2,  1], [-1,  2],
      [ 1,  2], [ 2,  1]
    ]
  end
end

# n = Knight.new(:black, 'br', [4,4])
# p n.moves

class King < Piece

end

class Pawn < Piece
end

require 'singleton'
class NullPiece < Piece
  attr_reader :symbol
  include Singleton

  def initialize
    @symbol = " "
    @color = :none
  end

  def empty?
    true
  end

  def moves
    []
  end
end
