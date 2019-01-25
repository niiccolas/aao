class Board
  attr_accessor :cups, :player1, :player2

  def initialize(player1, player2)
    @cups    = Array.new(14)
    @player1 = player1
    @player2 = player2
    place_stones
  end

  def place_stones
    cups.map!.with_index do |_cup, i|
      [13, 6].include?(i) ? [] : Array.new(4) { :stone }
    end
  end

  def valid_move?(start_pos)
    raise ArgumentError.new('Invalid starting cup') unless (0..14).include? start_pos
    raise ArgumentError.new('Starting cup is empty') if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones          = cups[start_pos] # take the stones
    cup_index       = start_pos # keep track of where we've taken the stones
    cups[start_pos] = [] # empty the cup we've just taken from

    until stones.empty?
      cup_index += 1
      # have player1 skip player2's point cup
      cup_index += 1 if current_player_name == player1 && cup_index == 13
      # have player2 skip player1's point cup
      cup_index += 1 if current_player_name == player2 && cup_index == 6
      cup_index = 0  if cup_index > 13 # cycle back to index 0 when reaching end of array
      cups[cup_index] << stones.pop
    end

    render
    next_turn(cup_index)
  end

  def next_turn(ending_cup_idx)
    if [13, 6].include? ending_cup_idx
      # a cup count of 1 after moving means the cup was empty: Switch players
      :prompt
    elsif cups[ending_cup_idx].count == 1
      # a cup count of 1 after moving means the cup was empty: Switch players
      :switch
    else
      # ended on a cup with stones already in it
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    cups[0..5].all?(&:empty?) || cups[7..12].all?(&:empty?)
  end

  def winner
    player1_score = cups[6].count
    player2_score = cups[13].count
    return :draw if player1_score == player2_score

    player1_score > player2_score ? player1 : player2
  end
end
