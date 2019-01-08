class AStar
  DELTAS = [[-1, 0], [0, -1], [0, 1], [1, 0]].freeze

  def initialize(maze)
    @maze = maze
  end
end