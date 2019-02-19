class TowerOfHanoi
  attr_accessor :towers, :num_discs

  def initialize(num_discs = 4)
    @towers     = Hash.new { [] }
    @towers[:T] = (1..num_discs).to_a
    @towers[:M] = []
    @towers[:B] = []
    @num_discs  = num_discs
  end

  def won?
    towers[:B].length == num_discs
  end

  def move(from, to)
    return "can't pick from an empty tower" if towers[from].empty?

    if towers[to].empty? || (towers[from].first < towers[to].first)
      towers[to].unshift(towers[from].shift)
    else
      raise 'Stack discs in ascending order only'
    end
  end

  def play
    until won?
      begin
        system('clear')
        display_piles
        move(*user_input)
      rescue StandardError => e
        puts e.to_s.upcase; sleep(1)
      end
    end

    puts "\nCongratulations, you found the solution!"
  end

  def display_piles
    towers.values.each { |tower| p tower }
  end

  def user_input
    controls = '(T)op, (M)iddle or (B)ottom'
    print "Pick from\t#{controls}: "
    from = gets.chomp.upcase.to_sym
    print "Move to  \t#{controls}: "
    to = gets.chomp.upcase.to_sym

    [from, to]
  end
end
