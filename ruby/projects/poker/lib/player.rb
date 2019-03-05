require_relative 'hand'

class Player
  attr_reader :hand, :name, :player_pot, :folded, :status

  def initialize(name = nil)
    @name       = name
    @hand       = Hand.new
    @player_pot = 50 # default starting pot
    @folded     = false
    @status     = ''
  end

  def bet?
    print prompt = '(F)old, (C)heck, (R)aise? '
    while (user_input = gets.chomp.upcase.to_sym)
      return fold      if user_input == :F
      return check_bet if user_input == :C
      return true      if user_input == :R

      print "Input error! Retry. #{prompt}"
    end
  end

  def raise_bet
    print prompt = "You can raise from 1 to #{player_pot}: "
    until (1..player_pot).cover?(player_raise = gets.chomp.to_i)
      print "Wrong input! #{prompt}"
    end

    puts "#{name} is ALL-IN!" if player_raise == player_pot
    @player_pot -= player_raise
    @status = "raised #{player_raise} 🍪"
    player_raise
  end

  def check_bet
    @status = 'checks'
    false
  end

  def fold
    @folded = true
    @status = 'folds'
    false
  end

  def pay(ante)
    @player_pot -= ante
  end

  def wins(game_pot)
    @player_pot += game_pot
  end

  def bankrupt?
    @player_pot.zero?
  end
end
