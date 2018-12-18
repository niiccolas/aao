require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_position
    position = nil
    until position && valid_position?(position)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        position = parse_position_input(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        position = nil
      end
    end
    position
  end

  def get_value
    value = nil
    until value && valid_value?(value)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      value = parse_value_input(gets.chomp)
    end
    value
  end

  def parse_position_input(string)
    string.split(",").map { |char| Integer(char) }
  end

  def parse_value_input(string)
    Integer(string)
  end

  def play_turn
    board.render
    position = get_position
    value    = get_value
    board[position] = value
    # pos_to_val(get_position, get_value)
  end

  def pos_to_val(position, value)
    board[pposition] = value
  end

  def run
    play_turn until board_solved?
    board.render
    puts "Congratulations, you win!"
  end

  def board_solved?
    board.solved?
  end

  def valid_position?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def valid_value?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end

game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.run
