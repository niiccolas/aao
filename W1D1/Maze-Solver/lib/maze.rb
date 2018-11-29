# :nodoc:
class Maze
  require 'matrix'
  attr_reader :maze, :current_position

  def initialize(maze_filename_txt)
    @maze = []
    Dir.chdir(File.dirname(__FILE__))
    maze_file = File.open(maze_filename_txt.first)
    maze_file.each_line { |line| @maze << line.chomp.chars }

    @current_position = start_point
  end

  def draw_maze
    maze.each { |el| puts el.join }
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
    @maze[current_row][current_row - 1] == 'E' ||
    @maze[current_row][current_row + 1] == 'E'
  end

  def pathfinder
    if empty_right
      move_right
    elsif empty_down
      move_down
    elsif empty_left
      move_left
    elsif empty_up
      move_up
    end

    mark_current_position
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
