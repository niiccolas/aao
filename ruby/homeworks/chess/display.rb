require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :cursor
  def initialize(board)
    @board  = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    puts "  #{('A'..'H').to_a.join(' ')}"
    @board.board.each_with_index do |row, i|
      row_number = (8 - i).to_s + ' '
      print row_number

      row.each_with_index do |col, j|
        if @cursor.cursor_pos == [i, j] && @cursor.selected
          print col.symbol.green + ' '
        elsif @cursor.cursor_pos == [i, j]
          print col.symbol.red + ' '
        else
          print col.symbol + ' '
        end
      end

      print ' ' + row_number
      puts
    end
    puts "  #{('A'..'H').to_a.join(' ')}"
  end
end

def test_display
  ch = Display.new(Board.new)
  system('clear')
  loop do
    ch.render
    ch.cursor.get_input
    system('clear')
  end
end

test_display
