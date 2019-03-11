require_relative 'hand'

class Player
  attr_reader :hand, :name, :player_pot, :tty, :id
  attr_accessor :status

  def initialize(id, name = nil)
    @name       = name
    @hand       = Hand.new
    @player_pot = 50 # default starting pot
    @status     = ' '
    @folded     = false
    @bankrupt   = false
    @id         = id
  end

  def hand_to_deck
    @hand = Hand.new
  end

  def bet(last_raise = false)
    print 'How much? $'
    player_raise = gets.to_i
    @status = if player_raise == player_pot
                'ALL-IN!'
              elsif last_raise
                "raises $#{player_raise}"
              else
                "bets $#{player_raise}"
              end

    take_from_pot(last_raise, player_raise)
  end

  def take_from_pot(last_raise, player_raise)
    if last_raise
      @player_pot -= (player_raise + last_raise)
      (player_raise + last_raise)
    else
      @player_pot -= player_raise
      player_raise
    end
  end

  def discard(hand_indices)
    discards = hand.cards.select.with_index { |_, i| hand_indices.include? i }
    # actually removing unwanted cards from Hand
    hand.cards.reject!.with_index { |_, i| hand_indices.include? i }

    discards
  end

  def call_bet(last_raise)
    @status      = "calls $#{last_raise}"
    @player_pot -= last_raise
  end

  def check
    @status = 'checks'
  end

  def fold
    pastel = Pastel.new
    @status = pastel.red.on_black('folded')
    @folded = true
  end

  def unfold
    @folded = false
  end

  def folded?
    @folded
  end

  def pay(ante)
    return 'BANKRUPT!' if @player_pot - ante < 0

    @status      = "paid $#{ante} ante"
    @player_pot -= ante
  end

  def wins(game_pot)
    @player_pot += game_pot
  end

  def bankrupt?
    @bankrupt
  end

  def bankrupt!
    @bankrupt = true
    @status = Pastel.new.decorate('BANKRUPT', :cyan, :on_black)
  end
end
