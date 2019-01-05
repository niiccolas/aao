require_relative '../polytreenode/lib/00_tree_node.rb'

class KnightPathFinder
  attr_accessor :starting_pos

  def initialize(position)
    @starting_pos = position
    @root_node = PolyTreeNode.new(@starting_pos)
  end
end
