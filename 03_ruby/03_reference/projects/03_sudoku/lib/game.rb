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
        solve_board
      rescue RuntimeError => e # Changing a "given" tile throws an error
        UI.warning(e)
      end
    end

    UI.congratulate(@elapsed_time)
  end

  private

  def solve_board
    input = @board.ui.keyboard_input

    # Valid input is returned as a Hash
    @board[*input[:pos]] = input[:val] if input.is_a? Hash
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new("./puzzles/#{ARGV[0]}").play
end
