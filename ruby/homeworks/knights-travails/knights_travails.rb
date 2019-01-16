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
    deltas.each do |delta|
      p delta
    end
  end

  def new_move_positions(pos)
    unless considered_positions.include?(pos)
      KnightPathFinder.valid_moves(pos)
      @considered_positions << pos
    end
  end
end
