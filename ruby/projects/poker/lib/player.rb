require_relative 'hand'
require 'tty-prompt'

class Player
  attr_reader :hand, :name, :player_pot, :tty
  attr_accessor :status

  def initialize(name = nil)
    @name       = name
    @hand       = Hand.new
    @player_pot = 50 # default starting pot
    @status     = ' '
    @tty        = TTY::Prompt.new
    @id         = id
  end

  def hand_to_deck
    @hand = Hand.new
  end

  def bet(last_raise = false)
    slider_options = { min: 1, max: @player_pot, step: 2, default: 3}
    puts player_raise = tty.slider('How much?', slider_options)
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

    @status      = "paid $#{ante} ante"
    @player_pot -= ante
  end

  def wins(game_pot)
    @player_pot += game_pot
  end

  def bankrupt?
    @player_pot.zero?
  end
end
