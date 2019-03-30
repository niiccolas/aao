class GhostUi
  def self.clear_screen
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
    end
  end

  def self.message_to_color(message, color)
    hues = {
      red: "\e[31m%s\e[0m",
      green: "\e[32m%s\e[0m",
      blue: "\e[34m%s\e[0m"
    }
    hues[color.intern] % message
  end

  def self.display_rules
    puts '            👻 Welcome to RubyGhost 👻'
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts 'In the game of Ghost, each player takes turns'
    puts 'adding a letter to an ever-growing word fragment.'
    puts '- Try NOT to spell a word (3 letters or more)'
    puts '- Get other players to spell a word'
    puts '- Get other players to say a letter that makes it'
    puts '  impossible to form a word'
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * *'
  end

  def self.display_standings(players, losses)
    round_num = losses.values.reduce(:+) + 1
    puts "            👻 RubyGhost - Round #{round_num} 👻"
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts
    players.each do |player|
      ghost_score = '_____'
      ghost_score[0, losses[player.name]] = ghost_score(player, losses)
      puts "#{player.name.capitalize}: #{ghost_score}"
    end
    puts
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * *'
  end

  def self.ghost_score(player, losses)
    'GHOST'.slice(0, losses[player.name])
  end

  def self.display_fragment(fragment)
    puts GhostUi.message_to_color("Current fragment: #{fragment.upcase}", :green) unless fragment.empty?
  end

  def self.display_guess_prompt(player, fragment)
    display_fragment(fragment)
    print "#{player.name.capitalize}'s turn, pick a letter: "
  end

  def self.display_ghosted_player(losses)
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts GhostUi.message_to_color("Goodbye #{losses.key(5).capitalize}, you've been ghosted 👻", :red)
  end

  def self.display_winner(losses)
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts GhostUi.message_to_color("🏅 CONGRATULATIONS #{losses.keys.first.capitalize} YOU WON! ✌️", :blue)
    puts
  end

  def self.display_lost_round(fragment, losses, previous_player, players)
    puts '* * * * * * * * * * * * * * * * * * * * * * * * * *'
    puts GhostUi.message_to_color("“#{fragment.upcase}” is a word! #{previous_player.name.capitalize} lost this round", :red)

    if players.all? { |player| player.type == 'ai' }
      # 3 second pause for watching all ai games
      sleep(3)
    else
      # mandatory reflection time before next round
      # unless a player has just been ghosted
      unless losses[previous_player.name] == 5
        loop do
          print GhostUi.message_to_color('Hit the RETURN key when ready for the next round...', :blue)
          break if gets == "\n"
        end
      end
    end
  end
end