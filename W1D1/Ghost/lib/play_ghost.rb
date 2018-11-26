require_relative './game.rb'

def register_players
  players = []

  print 'How many human players will be playing?: '
  gets.chomp.to_i.times do |player_number|
    print "Player ##{player_number + 1}, enter your name: "
    players << Player.new(gets.chomp)
  end

  print 'How many a.i. players will be playing?: '
  gets.chomp.to_i.times do
    players << AiPlayer.new
  end

  players
end

def welcome
  if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    system('cls')
  else
    system('clear')
  end

  puts '👻 Welcome to RubyGhost 👻'
  puts
end

def display_rules
  puts 'In the game of Ghost, each player takes turns'
  puts 'adding a letter to an ever-growing word fragment.'
  puts 'Try not to spell a word (of length 3 letters'
  puts 'or more). Try to force other players to spell'
  puts 'a word, or try to get a player to say a letter'
  puts 'that makes it impossible to form a word.'
  puts
end

welcome
display_rules
new_ghost_game = Game.new(register_players)
new_ghost_game.run
