require 'matrix'

# :nodoc:
class Maze
  DELTAS = [[-1, 0], [0, -1], [0, 1], [1, 0]].freeze

  attr_reader :maze, :start_index, :end_index #:current_position

  def initialize(maze_filename)
    @maze             = load_maze(maze_filename)
    @start_index      = find_start_index
    @end_index        = find_end_index
    # @current_position = start_point
  end

  def load_maze(maze_filename)
    maze = []
    Dir.chdir(File.dirname(__FILE__))
    File.open(maze_filename).each_line do |line|
    # File.open(maze_filename.first).each_line do |line|
      maze << line.chomp.chars
    end

    maze
  end

  def find_start_index
    find_char('S')
  end

  def find_end_index
    find_char('E')
  end

  def find_char(char)
    @maze.each_with_index do |row, i|
      row.each_with_index do |_col, j|
        return [j, i] if @maze[i][j] == char
      end
    end
  end

  def draw_maze
    maze.each { |row| puts row.join }
  end

  def start_point
    Matrix[*@maze].index('S')
  end

  def end_point
    Matrix[*@maze].index('E')
  end

  def current_row
    @current_position[0]
  end

  def current_column
    @current_position[1]
  end

  def mark_current_position
    @maze[current_row][current_column] = '#'
  end

  def move_right
    @current_position[1] = current_column + 1
  end
  def move_left
    @current_position[1] = current_column - 1
  end
  def move_up
    @current_position[0] = current_row - 1
  end
  def move_down
    @current_position[0] = current_row + 1
  end

  def adjacent_is_exit
    @maze[current_row][current_column + 1] == 'E' ||
    @maze[current_row][current_column - 1] == 'E' ||
    @maze[current_row - 1][current_column] == 'E' ||
    @maze[current_row + 1][current_column] == 'E'
  end

  def pathfinder
    if empty_right
      move_right
    elsif empty_up
      move_up
    elsif empty_down
      move_down
    elsif empty_left
      move_left
    end

    mark_current_position
  end

  def find_neighbors(point)
    point_x, point_y = point
    neighbors        = []

    DELTAS.each do |delta_x, delta_y|
      neighbor = [(delta_x + point_x), (delta_y + point_y)]
      neighbors << neighbor if in_maze?(neighbor) && !is_wall?(neighbor)
    end

    neighbors
  end

  def in_maze?(position)
    row, col = position
    (0...@maze.length).cover?(row) && (0...@maze.length).cover?(col)
  end

  def is_wall?(position)
    row, col = position
    @maze[row][col] == '*'
  end

  def empty_right
    @maze[current_row][current_column + 1] == ' '
  end

  def empty_left
    @maze[current_row][current_column - 1] == ' '
  end

  def empty_up
    @maze[current_row - 1][current_column] == ' '
  end

  def empty_down
    @maze[current_row + 1][current_column] == ' '
  end

  def run_maze_solver
    system('clear')
    until adjacent_is_exit
      pathfinder
      draw_maze
      sleep(0.05)
      system('clear') unless adjacent_is_exit
    end

    puts '🤖: Exit found!'
  end
end
