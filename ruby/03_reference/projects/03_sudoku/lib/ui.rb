require_relative 'cursor'
require 'chronic_duration'
require 'paint'

class UI
  attr_reader :cursor

  def initialize(board)
    @board   = board
    @squares = squares
    @cursor  = Cursor.new(@board)
  end

  def self.congratulate(game_start_time)
    elapsed_time = (Time.now - game_start_time).round
    parse_time   = ChronicDuration.output(elapsed_time, format: :short)
    congrats     = " Congratulations 👍\n Puzzle solved in #{parse_time}\n"

    puts Paint[congrats, 'gold', :bright]
  end

  def self.warning(error)
    puts Paint[" #{error.message}!\n Press Enter", :red, :bright]
    gets
  end

  def keyboard_input
    @cursor.keyboard_input
  end

  def draw(grid)
    system('clear')
    draw_top_border

    grid.each_with_index do |row, row_idx|
      draw_numbers(row)
      draw_middle_border if [2, 5].include?(row_idx)
      draw_bottom_border if row_idx == 8
      puts
    end
  end

  private

  def draw_numbers(row)
    num_col_borders = (@board.grid.length / @squares) + 1
    col_indices     = (0..num_col_borders * @squares).step(num_col_borders).to_a
    row_idx         = @board.grid.index(row)

    dup_row = []
    row.each_with_index do |el, i|
      if @cursor.position == [row_idx, i]
        dup_row << Paint[el.to_s, 'gold', :bright, :underline]
      else
        dup_row << el.to_s
      end
    end

    col_indices.each { |i| dup_row.insert(i, '│ ') }
    print dup_row.join(' ').chop
  end

  def draw_top_border
    print Paint[' SUDOKU', 'gold']
    print Paint["RB \n", :red, ]
    print "┌#{line}┬#{line}┬#{line}┐\n"
  end

  def draw_middle_border
    print "\n├#{line}┼#{line}┼#{line}┤"
  end

  def draw_bottom_border
    print "\n└#{line}┴#{line}┴#{line}┘"
  end

  def line
    '─' * (@board.grid.length - 1)
  end
end
