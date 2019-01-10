require_relative 'maze'

class AStar
  DELTAS = [[-1, 0], [0, -1], [0, 1], [1, 0]].freeze

  def initialize(maze)
    @maze = maze
  end

  def solve(heuristic)
    build_branching_paths(heuristic)
    path = find_path
    @maze.travel_path(path)
end