require_relative '../polytreenode/lib/00_tree_node.rb'

class KnightPathFinder
  attr_reader :starting_pos, :root_node, :considered_positions

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

  def initialize(position = [0, 0])
    @starting_pos = position
    @root_node = PolyTreeNode.new(@starting_pos)
    @considered_positions = [@starting_pos]
    build_move_tree
  end

  def build_move_tree
    queue = [root_node]

    until queue.empty?
      current_node = queue.shift # FIFO
      current_pos  = current_node.value

      new_move_positions(current_pos).each do |new_move_position|
        next_node = PolyTreeNode.new(new_move_position)
        current_node.add_child(next_node)
        queue << next_node
      end
    end
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

  def find_path(end_pos)
    trace_path_back(root_node.bfs(end_pos))
  end

  def trace_path_back(node)
    return [node.value] if node.parent == nil

    trace_path_back(node.parent) + [node.value]
  end
end
