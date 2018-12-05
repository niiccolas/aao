require_relative 'board'
require_relative 'human_player'

class MemoryGame
  attr_reader :player

  def initialize(player, board_size = 4)
    @memory_game       = Board.new(board_size)
    @previous_guess    = nil
    @player            = player
  end

  def match?(pos1, pos2)
    @memory_game[pos1] == @memory_game[pos2]
  end

  def play
    @memory_game.render_cheat # enables god mode

    until @memory_game.won?
      @memory_game.render
      pos = get_player_input
      make_guess(pos)
    end

    puts 'Congratulations, you won!'
  end

  def compare_guess(new_guess)
    if @previous_guess
      if match?(previous_guess, new_guess)
        player.receive_match(previous_guess, new_guess)
      else
        puts 'Try again.'
        [previous_guess, new_guess].each { |pos| @memory_game.hide(pos) }
        sleep(1)
      end
      self.previous_guess   = nil
      player.previous_guess = nil
    else
      self.previous_guess   = new_guess
      player.previous_guess = new_guess
    end
  end

  def get_player_input
    pos = nil
    pos = player.get_input until pos && valid_pos?(pos)

    pos
  end

  def make_guess(pos)
    revealed_value = @memory_game.reveal(pos)
    player.receive_revealed_card(pos, revealed_value)
    @memory_game.render

    compare_guess(pos)
  end

  def match?(pos1, pos2)
    @memory_game[pos1] == @memory_game[pos2]
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.count == 2 &&
      pos.all? { |e| e.between?(0, memory_game.board_size - 1) }
  end

  private

  attr_accessor :previous_guess
  attr_reader   :memory_game
end

new_memory_game = MemoryGame.new(HumanPlayer.new)
new_memory_game.play
