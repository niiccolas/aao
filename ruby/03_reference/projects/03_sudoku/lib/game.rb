require_relative 'board'
require_relative 'ui'
require 'colorize'

class Game
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def play
    loop do
      @board.render
      break if @board.solved?

      begin
        user_input = prompt
        @board[*user_input[:pos]] = user_input[:val][0]
      rescue RuntimeError => e
        puts "Error: #{e.message}. Press enter to continue".red
        gets
      end
    end
    UI.congratulate
  end

  def prompt
    %i[pos val].each.with_object({}) do |key, user_input|
      print key == :pos ? 'Position? (e.g. 91): ' : 'Value? (1-9):    '

      user_input[key] = gets.chomp.chars.map(&:to_i)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new('./puzzles/sudoku1.txt').play
end
