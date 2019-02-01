require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :cursor, :board
  def initialize(board)
    @board  = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    puts "  #{('a'..'h').to_a.join(' ')}"
    @board.board.each_with_index do |row, i|
      row_number = (8 - i).to_s + ' '
      print row_number

      row.each_with_index do |col, j|
        colors = colorize_tile(i, j)
        print "#{col.symbol.black} ".colorize(colors)
      end
      puts
    end

    puts "\nArrows to move cursor,\nSpace bar to select/release"
  end

  def colorize_tile(i, j)
    if @cursor.cursor_pos == [i, j] && @cursor.selected
      bg_color = :red
    elsif @cursor.cursor_pos == [i, j]
      bg_color = :green
    elsif (i + j).odd?
      bg_color = :light_cyan
    else
      bg_color = :light_white
    end
    { background: bg_color }
  end
end

def test_display
  chess_board = Display.new(Board.new)
  system('clear')
  move_to = []

  loop do
    chess_board.render
    current_move = chess_board.cursor.get_input
    move_to << current_move unless current_move.nil?
    system('clear')

    if move_to.length == 2
      chess_board.board.move_piece(move_to[0], move_to[1])
      move_to = []
    end
  end
end

test_display
