class TowerOfHanoi
  RED = "\e[31m%s\e[0m".freeze

  attr_accessor :towers, :num_discs, :rule_no_empty_from, :rule_no_larger_disk

  def initialize(num_discs = 4)
    @towers     = Hash.new { [] }
    @towers[:L] = %w[o oo ooo oooo] # left
    @towers[:C] = []                # center
    @towers[:R] = []                # right
    @num_discs  = num_discs

    @rule_no_larger_disk = 'No larger disk may be placed on a smaller disc'
    @rule_no_empty_from = 'Origin tower must contain a disc'
  end

  def display_controls
    print "\t(" + RED % 'l' + ')eft, '
    print '(' + RED % 'c' + ')enter, '
    print 'or (' + RED % 'r' + ')ight tower: '
  end


  def current_tower
    print 'Move disc from the '
    display_controls
    gets.chomp.upcase.to_sym
  end

  def deposit_tower
    print 'Leave disc in the '
    display_controls
    gets.chomp.upcase.to_sym
  end

  def move_disc(from, to)
    # p towers[from]
    # p towers[to]
    return error_msg(rule_no_empty_from) if towers[from] == []

    if towers[to].empty?
      towers[to] << towers[from].shift
    elsif towers[from].first.length < towers[to].first.length
      towers[to].unshift(towers[from].shift)
    else
      error_msg(rule_no_larger_disk)
    end
  end

  def error_msg(msg)
    puts RED % "\nIMPOSSIBLE!"
    puts msg + '. Retry.'
    sleep(3)
  end

  def play
    until game_over?
      draw_towers
      move_disc(current_tower, deposit_tower)
    end
    draw_towers

    puts 'YOU WIN!'
  end

  def game_over?
    towers[:R].length == num_discs && towers[:R] == towers[:R].sort
  end

  def draw_towers
    system('clear')
    # puts towers
    p towers.values
  end
end

TowerOfHanoi.new.play
