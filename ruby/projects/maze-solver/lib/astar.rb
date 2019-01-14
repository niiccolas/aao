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

  def build_branching_paths(heuristic = :manhattan_heuristic)
    # initialize/reset the following instance variables:
    # @branching_path
    # @current_pos
    reset_path

    queue   = [@current_pos]
    visited = [@current_pos]

    until queue.empty? || @current_pos == @maze.maze_exit
      @current_pos = manhattan_heuristic(queue)
      queue.delete(@current_pos)
      visited << @current_pos

      adjacent_positions = @maze.find_neighbors(@current_pos)
      adjacent_positions.each do |position|
        unless visited.include?(position) || queue.include?(position)
          queue << position
          @branching_path[position] = @current_pos
        end
      end
    end

    @branching_path
  end

  def reset_path
    @branching_path = {}
    @current_pos    = @maze.maze_entrance
  end

  def manhattan_heuristic(queue)
    queue.inject do |first_loc, next_loc|
      old_f = manhattan_estimate(first_loc)
      new_f = manhattan_estimate(next_loc)

      # Return the location with the lowest "f" score
      old_f > new_f ? next_loc : first_loc
    end
  end

  def manhattan_estimate(point)
    traveled_so_far = path_to_exit(point).length

    distance_to_exit(point) + traveled_so_far
  end

  def distance_to_exit(point)
    point_x, point_y = point
    exit_x,  exit_y  = @maze.maze_exit

    ((point_x - exit_x) + (point_y - exit_y)).abs
  end

  def path_to_exit(goal = @maze.maze_exit)
    path = [goal]
    spot = goal

    until @branching_path[spot] == nil
      path << @branching_path[spot]

      # To go BACK UP the history of @branching_path using the until loop
      # we reassign spot to its parent location
      spot = @branching_path[spot]
    end
    path
  end
end