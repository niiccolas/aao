require_relative './game.rb'
require_relative './player.rb'

def group_of_players
  players = []
  puts '~ ~ ~  Welcome to RubyGhost 👻  ~ ~ ~'
  print 'How many people will be playing?: '
  num_players = gets.chomp.to_i

  num_players.times do |player_number|
    print "Name for Player #{player_number + 1}: "
    players << Player.new(gets.chomp)
  end
  puts "Let's ghost!\n~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~\n"
  players
end

new_ghost_game = Game.new(group_of_players)
new_ghost_game.run
