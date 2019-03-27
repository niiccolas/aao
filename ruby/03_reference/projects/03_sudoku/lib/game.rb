require_relative 'board'
require_relative 'ui'

class Game
  attr_reader :board

  def initialize(puzzle_file)
    @board        = Board.new(puzzle_file)
    @elapsed_time = Time.now
  end

  def play
    loop do
      @board.render
      break if @board.solved?

      begin
        solve_board(user_input)
      rescue RuntimeError => e # Changing a "given" tile throws an error
        UI.warning(e)
      end
    end

    UI.congratulate(@elapsed_time)
  end

  private

  def solve_board(user_input)
    if user_input.is_a? Hash # Validated input is sent as Hash
      @board[*user_input[:pos]] = user_input[:val]
    end
  end

  def user_input
    @board.ui.keyboard_input
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new('./puzzles/sudoku1.txt').play
end
