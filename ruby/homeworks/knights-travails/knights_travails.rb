require_relative '../polytreenode/lib/00_tree_node.rb'

class KnightPathFinder
  attr_accessor :starting_pos, :considered_positions

  KNIGHT_MOVES = [
    [-1, -2],
    [-2, -1],
    [-2,  1],
    [-1,  2],
    [ 1, -2],
    [ 2, -1],
    [ 2,  1],
    [ 1,  2]
  ].freeze

  def initialize(position = [0,1])
    @starting_pos = position
    @root_node = PolyTreeNode.new(@starting_pos)
    @considered_positions = [@starting_pos]
  end

  def self.valid_moves(pos)
    valid_moves  = []
    pos_x, pos_y = pos

    KNIGHT_MOVES.each do |move|
      move_x, move_y = move
      valid_move     = [(pos_x - move_x), (pos_y - move_y)]
      valid_moves << valid_move if within_board?(valid_move)
    end

    valid_moves
  end

  def self.within_board?(pos)
    row, col = pos
    # (0..7) as indices of a standard 8x8 chess board
    (0..7).cover?(row) && (0..7).cover?(col)
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos)
      .reject { |move_pos| considered_positions.include?(move_pos) }
      .each   { |move_pos| considered_positions << move_pos }
  end
end
