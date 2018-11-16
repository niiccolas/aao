require_relative 'board'
require_relative 'player'

# :nodoc:
class Battleship
  def initialize(n)
    @player = Player.new
    @board = Board.new(n)
    @remaining_misses = @board.size / 2
  end

  attr_reader :board, :player

  def start_game
    @board.place_random_ships
    puts "\nThere are #{@board.num_ships} hidden ships on the board.\nGood luck captain!"
    puts
    @board.print
  end

  def lose?
    return false if @remaining_misses > 0

    puts
    puts '- - - - -'
    puts 'you lose'
    puts '- - - - -'
    true
  end

  def win?
    if @remaining_misses > 0 && @board.num_ships.zero?
      puts
      puts '* * * *'
      puts 'you win'
      puts '* * * *'
      return true
    end
    false
  end

  def game_over?
    return true if lose? || win?

    false
  end

  def turn
    @remaining_misses -= 1 unless @board.attack(@player.get_move)
    @board.print
    puts @remaining_misses
  end
end
