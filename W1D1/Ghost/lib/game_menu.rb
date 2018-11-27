require_relative './game.rb'
require_relative './ghost_ui.rb'

# :nodoc:
class GameMenu
  def self.launch_new_game
    Game.new(register_players).run
  end

  def self.register_players
    players = []

    print GhostUi.message_to_color('How many HUMAN 👫 players will be playing?: ', :green)
    number_of_players.to_i.times do |player_number|
      print GhostUi.message_to_color("Player ##{player_number + 1}, enter your name: ", :red)
      players << Player.new(gets.chomp)
    end

    print GhostUi.message_to_color("\nHow many A.I. 🤖 players will be playing?: ", :green)
    number_of_players.chomp.to_i.times do
      players << AiPlayer.new
    end

    players
  end

  def self.number_of_players
    num = gets.chomp
    until valid_number?(num)
      print GhostUi.message_to_color('Error! Numbers only, retry: ', :red)
      num = gets.chomp
    end
    num
  end

  def self.valid_number?(number)
    /[0-9]/.match?(number)
  end
end

GhostUi.clear_screen
GhostUi.display_rules
GameMenu.launch_new_game
