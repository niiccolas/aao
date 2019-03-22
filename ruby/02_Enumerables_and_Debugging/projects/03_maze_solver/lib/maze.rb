require 'colorize'

# :nodoc:
class Maze
  DELTAS = [[-1, 0], [0, -1], [0, 1], [1, 0]].freeze

  attr_reader :maze, :maze_exit, :maze_entrance

  def initialize(maze_filename)
    @maze          = load_maze(maze_filename)
    @maze_exit     = find_exit
    @maze_entrance = find_entrance
  end

  def load_maze(maze_filename)
    maze = []
    Dir.chdir(File.dirname(__FILE__))
    File.open(maze_filename).each_line do |line|
      maze << line.chomp.chars
    end

    maze
  end

  def find_entrance
    find_char('S')
  end

  def find_exit
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
    system('clear')
    maze.each { |row| puts row.join }
    sleep(0.05)
  end

  def find_neighbors(point)
    point_x, point_y = point
    neighbors        = []

    DELTAS.each do |delta_x, delta_y|
      neighbor = [(delta_x + point_x), (delta_y + point_y)]
      neighbors << neighbor if in_maze?(neighbor) && !wall?(neighbor)
    end

    neighbors
  end

  def in_maze?(position)
    row, col             = position
    coords_positive      = row.positive? && col.positive?
    coords_within_bounds = row <= @maze[0].length && col <= @maze.length

    coords_positive && coords_within_bounds
  end

  def wall?(position)
    col, row = position
    @maze[row][col] == '*'
  end

  def travel_path(path)
    if path.length > 1
      path.reverse_each do |pos|
        row, col = pos
        @maze[col][row] = 'X'.green
        draw_maze
      end
      puts "We're out of here".green
    else
      draw_maze
      puts 'There is no way out'.red
    end
  end
end
