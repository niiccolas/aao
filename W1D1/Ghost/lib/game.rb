require_relative './player.rb'

# :nodoc:
class Game
  attr_accessor :fragment, :dictionary, :players, :losses

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

  def take_turn(player)
    print "Your turn #{player.name.capitalize}, pick a letter: #{@fragment}"
    guess = player.guess

    loop do
      break if valid_play?(guess)

      player.alert_invalid_guess
      guess = player.guess
    end

    @fragment += guess
    next_player!
  end

  def valid_play?(string)
    # return false unless ('a'..'z').cover?(string) && string.length == 1

    possible_word = @fragment + string
    @dictionary.each_key do |key|
      return true if key.start_with? possible_word
    end
    false
  end

  def play_round
    take_turn(current_player) until @dictionary.key? @fragment

    print "“#{@fragment.upcase}” is a word!"
    print " #{previous_player.name.capitalize} lost this round.\n"
    @losses[previous_player.name] += 1
  end

  def record(player)
    'GHOST'.slice(0, @losses[player.name])
  end

  def display_standings
    puts "\nGhost Scores:"
    ghost_score = '_____'
    @players.each do |player|
      ghost_score[0, @losses[player.name]] = record(player)
      puts "#{player.name.capitalize}: #{ghost_score}"
    end
    puts
  end

  def run
    until @players.count == 1
      until @losses.values.any? { |value| value.eql?(5) }
        @fragment = ''
        display_standings
        play_round
      end
      puts "\n*** 👻 #{@losses.key(5).capitalize} has been ghosted! 👻 ***"
      @players.delete_if { |player| player.name == @losses.key(5) }
      @losses.delete(@losses.key(5))
    end
    puts "+++ ✌️  #{@losses.keys.first.capitalize} WINS ✌️  +++"
  end
end
