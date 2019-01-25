class Board
  attr_accessor :cups, :player1, :player2

  def initialize(name1, name2)
    @cups = Array.new(14)
    place_stones
  end

  def place_stones
    stone_cup = [:stone] * 4
    cups.map!.with_index do |_cup, i|
      [13, 6].include?(i) ? '' : Array.new(4) { :stone }
    end
  end

  def valid_move?(start_pos)
    raise ArgumentError.new('Invalid starting cup') unless (0..14).include? start_pos

    raise ArgumentError.new('Starting cup is empty') if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
