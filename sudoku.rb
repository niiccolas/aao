require_relative "board"
require 'colorize'

puts "Only contractors write code this bad.".yellow

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = parse_pos(gets.chomp)
      rescue => error
        # TODO: Google how to print the error that happened inside of a rescue statement.
        puts "Invalid position entered (did you use a comma?)".red
        puts ""

        pos = nil
      end
    end
    pos
  end

  def parse_pos(string)
    string.split(',').map(&:to_i)
  end

  def parse_val(string)
    string.to_i
  end

  def get_val
    val = nil
    until val && valid_val?(val)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      val = parse_val(gets.chomp)
    end
    val
  end

  def play_turn
    board.render
    pos = get_pos
    val = get_val
    board[pos] = val
  end

  def run
    play_turn until solved?
    board.render
    puts "Congratulations, you win!"
  end

  def solved?
    board.solved?
  end

  def valid_pos?(pos)
    if pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
      return true
    else
      get_pos
    end
  end

  def valid_val?(val)
    val.is_a?(Integer) ||
      val.between?(0, 9)
  end

  private
  attr_reader :board
end

game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.run
