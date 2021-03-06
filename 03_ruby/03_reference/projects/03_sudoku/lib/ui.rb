require_relative 'cursor'
require 'chronic_duration'
require 'paint'

class UI
  AI_SOLVER = caller_locations.any? { |e| e.to_s.include? 'solver' }

  attr_reader :cursor

  def initialize(board)
    @board     = board
    @cursor    = AI_SOLVER ? nil : Cursor.new(@board)
  end

  def self.congratulate(game_start_time)
    elapsed_time = (Time.now - game_start_time).round
    parse_time   = ChronicDuration.output(elapsed_time, format: :long)
    congrats     = " Pretty good 👍\n Puzzle solved in #{parse_time}\n"

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
    rendered_row = []
    row.each_with_index do |el, i|
      if AI_SOLVER || @cursor.position != [@board.grid.index(row), i]
        rendered_row << el.to_s
      else
        rendered_row << Paint[el.to_s, 'gold', :bright, :underline]
      end
    end

    # Draw each square's vertical lines
    [0, 4, 8, 12].each { |i| rendered_row.insert(i, '│ ') }

    print rendered_row.join(' ')
  end

  def draw_top_border
    print Paint[' SUDOKU', 'gold']
    print Paint["RB \n", :red]
    print "┌#{horizontal}┬#{horizontal}┬#{horizontal}┐\n"
  end

  def draw_middle_border
    print "\n├#{horizontal}┼#{horizontal}┼#{horizontal}┤"
  end

  def draw_bottom_border
    print "\n└#{horizontal}┴#{horizontal}┴#{horizontal}┘"
  end

  def horizontal
    '─' * (@board.grid.length - 1)
  end
end
