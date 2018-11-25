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

  def record(player)
    'GHOST'.slice(0, @losses[player.name])
  end

  def eliminate_ghosted_player
    @players.delete_if { |player| player.name == @losses.key(5) }
    @losses.delete(@losses.key(5))
  end

  def run
    until @players.count == 1
      until @losses.values.any? { |value| value.eql?(5) }
        clear_screen
        clear_fragment
        display_standings
        play_round
      end

      display_ghosted_player
      eliminate_ghosted_player
    end
    display_winner
  end

  def clear_fragment
    @fragment = ''
  end

  def play_round
    take_turn(current_player) until @dictionary.key? @fragment

    @losses[previous_player.name] += 1
    display_lost_round
  end

  def take_turn(player)
    prompt_player(player)
    guess = player.guess(@dictionary, @fragment)
    if player.type == 'ai'
      print guess
      puts
    end

    loop do
      break if valid_play?(guess)

      player.alert_invalid_guess(guess, fragment)
      guess = player.guess
    end

    @fragment += guess
    next_player!
  end

  # UI methods, display prompts & status
  def display_standings
    round_num = losses.values.reduce(:+) + 1

    puts "Round n°#{round_num} - Ghost Scores:"
    ghost_score = '_____'
    @players.each do |player|
      ghost_score[0, @losses[player.name]] = record(player)
      puts "#{player.name.capitalize}: #{ghost_score}"
    end
    puts
  end

  def prompt_player(player)
    puts
    puts "current fragment: #{@fragment.upcase}" unless @fragment.empty?
    print "Your turn #{player.name.capitalize}, pick a letter: "
  end

  def display_ghosted_player
    puts "\n*** 👻 #{@losses.key(5).capitalize} has been ghosted! 👻 ***"
  end

  def display_winner
    puts
    puts "+++ ✌️  #{@losses.keys.first.capitalize} WINS ✌️  +++"
  end

  def display_lost_round
    puts
    print "*** “#{@fragment.upcase}” is a word!"
    print " #{previous_player.name.capitalize} lost this round ***\n"

    sleep(2) unless @losses[previous_player.name] == 5
  end

  def clear_screen
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
    end
  end
end
