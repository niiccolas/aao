require_relative 'card'

class Board
  attr_reader :grid, :board_size

  def initialize(board_size = 4)
    @grid = Array.new(board_size) { Array.new(board_size) }
    @board_size = board_size
    populate
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def hide(pos)
    self[pos].hide
  end

  def reveal(pos)
    if self[pos].revealed?
      puts "This card has already been revealed! Retry"
      sleep(1)
    else
      self[pos].reveal
    end
    self[pos].value
  end

  def revealed?(pos)
    self[pos].revealed?
  end

  def populate
    num_pairs = (board_size**2) / 2
    temp_cards = Card.shuffled_pairs(num_pairs)
    grid.each_index do |idx1|
      grid[idx1].each_index do |idx2|
        self[[idx1, idx2]] = temp_cards.pop
      end
    end
  end

  def render
    system('clear')
    puts '  ' + (0...board_size).to_a.join(' ')

    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
  end

  def render_cheat
    # system('clear')
    @grid.each do |row|
      row.each do |card|
        card.reveal
      end
    end
    puts '  ' + (0...board_size).to_a.join(' ')

    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end

    @grid.each do |row|
      row.each do |card|
        card.hide
      end
    end
  end

  def won?
    grid.all? { |row| row.all?(&:revealed?) }
  end
end
