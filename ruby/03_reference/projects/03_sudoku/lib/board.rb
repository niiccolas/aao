require_relative 'tile'
require_relative 'ui'

class Board
  INTERVALS = [[*0..2], [*3..5], [*6..8]].freeze

  def initialize(grid_file)
    @grid      = Board::from_file(grid_file)
    @intervals = [[*0..2], [*3..5], [*6..8]]
    @ui        = UI.new(self)
  end

  def self.from_file(file)
    Dir.chdir(File.dirname(__FILE__))

    File.open(file).each.with_object([]) do |line, array|
      array << line.chomp.chars.map { |num| Tile.new(num.to_i) }
    end
  end

  def [](*position)
    x, y = position
    @grid[x][y]
  end

  def []=(*position, value)
    x, y = position
    @grid[x][y].value = value
  end

  def render
    ui.draw(@grid)
  end

  def solved?
    rows_solved? && columns_solved? && squares_solved?
  end

  def valid_pos?(pos)
    [*0..8].product([*0..8]).include? pos
  end

  private

  def rows_solved?
    grid.all? do |row|
      row.map(&:value).compact.uniq.length == grid.length
    end
  end

  def columns_solved?
    grid.transpose.all? do |col|
      col.map(&:value).compact.uniq.length == grid.length
    end
  end

  def squares_solved?
    INTERVALS.each do |int1|
      INTERVALS.each do |int2|
        square = int1.product(int2).map! do |pos|
          x, y = pos
          @grid[x][y].value
        end

        return false unless square.compact.uniq.length == grid.length
      end
    end
    true
  end
end
