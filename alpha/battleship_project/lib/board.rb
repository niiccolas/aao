# :nodoc:
class Board
  attr_reader :size

  def self.print_grid(grid)
    grid.each do |row|
      print row.join(' ')
      puts
    end
  end

  def initialize(n)
    # Ruby Doc Array.new: "If multiple copies are what you want,
    # you should use the block version which uses the result
    # of that block each time an element of the array
    # needs to be initialized:
    @grid = Array.new(n) { Array.new(n, :N) }
    @size = n * n
  end

  def [](position)
    @grid[position[0]][position[1]]
  end

  def []=(position, value)
    @grid[position[0]][position[1]] = value
  end

  def num_ships
    @grid.flatten.count(:S) # Fortius

    # @grid.map { |row| row.count(:S) }.sum # Altius

    # ships_count = 0 # Citius
    # @grid.each do |row|
    #   row.each do |square|
    #     ships_count += 1 if square == :S
    #   end
    # end
    # ships_count
  end

  def attack(position)
    if self[position] == :S
      puts 'you sunk my battleship!'
      self[position] = :H # HIT!
      return true
    end
    self[position] = :X # MISS!
    false
  end

  def place_random_ships
    until num_ships == @size / 4 # set 25 % of grid to Ships
      position = [rand(0...@grid.length), rand(0...@grid.length)]
      self[position] = :S unless self[position] == :S
    end
  end

  def hidden_ships_grid
    hidden = [] # duplicate the @grid array before alteration
    @grid.each { |row| hidden << row.dup }

    hidden.map do |row|
      row.map! { |square| square == :S ? :N : square }
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end
