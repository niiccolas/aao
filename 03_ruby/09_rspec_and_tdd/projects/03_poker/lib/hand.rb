require_relative 'deck'
require 'colorize'

class Hand
  HANDS = {
    royal_straight_flush: { value: 10 },
    straight_flush: { value: 9 },
    four_of_a_kind: { value: 8, layout: { n_same_rank: 4, occurence: 1 } },
    full_house: { value: 7 },
    flush: { value: 6 },
    straight: { value: 5 },
    three_of_a_kind: { value: 4, layout: { n_same_rank: 3, occurence: 1 } },
    two_pair: { value: 3, layout: { n_same_rank: 2, occurence: 2 } },
    pair: { value: 2, layout: { n_same_rank: 2, occurence: 1 } },
    high_card: { value: 1, layout: { n_same_rank: 1, occurence: 5 } }
  }.freeze

  attr_reader :cards

  def initialize
    @cards = []
  end

  def sort_by_rank
    @cards.sort_by!(&:rank)
  end

  def add_card(card)
    @cards << card
  end

  def draw
    suits = cards.map { |card| draw_suit(card.suit) }
    faces = cards.map { |card| card.face.to_s }

    suits.zip(faces).map(&:join).join(' ')
  end

  def draw_suit(suit)
    if suit == :spades
      '♠'.green
    elsif suit == :clubs
      '♣'.green
    elsif suit == :diamonds
      '♦'.red
    elsif suit == :hearts
      '♥'.red
    end
  end

  def ranks
    cards.map(&:rank)
  end

  def name
    hand_name = HANDS.find { |_key, hash| hash[:value] == hand_value }.first
    hand_name.to_s.tr('_', ' ').capitalize
  end

  def hand_value
    hand_methods = HANDS.keys.map(&:to_s).map { |hand| (hand + '?').to_sym }

    # Enumerating thru ::HANDS keys being poker hand names,
    # send calls to each hand checking method (pair?, two_pair?, etc.).
    # When current hand is identified, return its :value from ::HANDS
    hand_methods.each do |hand_method|
      return HANDS[hand_method.to_s.chop.to_sym][:value] if send(hand_method)
    end
  end

  def winning_hand?(*hands)
    best_hand = hands.all? { |rival| hand_value > rival.hand_value }
    tie = hands.any? { |rival| hand_value == rival.hand_value }
    best_kicker = hands.all? { |rival| kicker_value > rival.kicker_value }

    if best_hand
      true
    elsif tie
      best_kicker ? true : false
    else
      false
    end
  end

  def kicker_value
    cards.map(&:rank).sum
  end

  def in_sequence?
    in_order = ranks.map.with_index do |_el, i|
      i.zero? ? nil : ranks[i - 1] + 1 == ranks[i]
    end.drop(1) # remove the first `nil` element for upcoming Boolean comparison

    in_order.all? { |e| e == true }
  end

  def same_suit?
    cards.map(&:suit).uniq.size == 1
  end

  def straight?
    in_sequence?
  end

  def flush?
    !in_sequence? && same_suit?
  end

  def straight_flush?
    in_sequence? && same_suit? &&
      !royal_straight_flush?
  end

  def royal_straight_flush?
    in_sequence? && same_suit? &&
      cards.map(&:face) == %i[10 J Q K A]
  end

  def full_house?
    same_ranks = ranks.each_with_object(Hash.new(0)) do |value, hash|
      hash[value] += 1
    end.values

    same_ranks.sort == [2, 3]
  end

  # Create methods for checking hands based on rank siblings
  HANDS.keys.select { |el| el =~ /pair|kind|high/ }.each do |hand|
    define_method(hand.to_s + '?') do
      same_ranks = ranks.each_with_object(Hash.new(0)) do |value, hash|
        hash[value] += 1
      end.values

      same_ranks.count(HANDS[hand][:layout][:n_same_rank]) ==
        HANDS[hand][:layout][:occurence]
    end
  end

  def hand_name
    HANDS.each do |name, value|
      return name.to_s.capitalize.tr('_', ' ') if value.value?(hand_value)
    end
  end
end
