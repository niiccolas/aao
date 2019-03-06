require_relative 'hand'

class Player
  attr_reader :hand, :name, :player_pot
  attr_accessor :status

  def initialize(name = nil)
    @name       = name
    @hand       = Hand.new
    @player_pot = 51 # default starting pot
    @status     = ''
  end

  def hand_to_deck
    @hand = Hand.new
  end

  def bet(last_raise = false)
    prompt = last_raise ? 'raise' : 'bet'
    print "How many chips to #{prompt}? "

    until (1..player_pot).cover?(player_raise = gets.chomp.to_i)
      print 'Wrong input! Retry: '
    end

    if player_raise == player_pot
      @status = "ALL-IN!"
    elsif last_raise
      @status = "Calls #{last_raise} and #{prompt}s #{player_raise}"
    else
      @status = "#{prompt}s #{player_raise}"
    end

    if last_raise
      @player_pot -= (player_raise+ last_raise)
      (player_raise + last_raise)
    else
      @player_pot -= player_raise
      player_raise
    end
  end

  def discard(hand_indices)
    rejects = hand.cards.select.with_index { |_, i| hand_indices.include? i }

    # actually removing unwanted cards from Hand
    hand.cards.reject!.with_index { |_, i| hand_indices.include? i }

    rejects
  end

  def call_bet(last_raise)
    @status      = 'calls'
    @player_pot -= last_raise
  end

  def check
    @status = 'checks'
  end

  def fold
    @status = 'folded'
  end

  def pay(ante)
    return 'BANKRUPT!' if @player_pot - ante < 0

    @status      = "paid ante ($#{ante})"
    @player_pot -= ante
  end

  def wins(game_pot)
    @player_pot += game_pot
  end

  def bankrupt?
    @player_pot.zero?
  end
end
