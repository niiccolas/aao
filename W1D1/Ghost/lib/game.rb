require_relative './player.rb'
require_relative './aiplayer.rb'

# :nodoc:
class Game
  attr_reader :fragment, :dictionary, :players, :losses

  def initialize(players)
    @players    = players
    @fragment   = ''
    @dictionary = {}
    @losses     = Hash[*@players.collect { |player| [player.name, 0] }.flatten]

    Dir.chdir(File.dirname(__FILE__)) # dictionary file is in /lib
    File.open('dictionary.txt').each_line do |word|
      @dictionary[word.chomp] = true
    end
  end

  def current_player
    @players.first
  end

  def previous_player
    @players.last
  end

  def next_player!
    @players.rotate!
  end

  def valid_play?(string)
    return false unless ('a'..'z').cover?(string) && string.length == 1

    possible_word = @fragment + string
    @dictionary.each_key do |key|
      return true if key.start_with? possible_word
    end
    false
  end

  def run
    until @players.count == 1
      until @losses.values.any? { |value| value.eql?(5) }
        GhostUi.clear_screen
        clear_fragment
        play_round
      end
      GhostUi.display_ghosted_player(@losses)
      eliminate_ghosted_player
    end
    GhostUi.display_winner(@losses)
  end

  def clear_fragment
    @fragment = ''
  end

  def play_round
    GhostUi.clear_screen
    GhostUi.display_standings(@players, @losses)

    take_turn(current_player) until @dictionary.key? @fragment

    @losses[previous_player.name] += 1
    GhostUi.display_lost_round(@fragment, @losses, previous_player, @players)
  end

  def take_turn(player)
    GhostUi.display_guess_prompt(player, @fragment)
    guess = player.guess(@dictionary, @fragment)
    if player.type == 'ai'
      print guess
      puts
    end

    loop do
      break if valid_play?(guess)

      player.alert_invalid_guess(guess)
      guess = player.guess
    end

    @fragment += guess
    next_player!
  end

  def eliminate_ghosted_player
    @players.delete_if { |player| player.name == @losses.key(5) }
    @losses.delete(@losses.key(5))
  end
end
