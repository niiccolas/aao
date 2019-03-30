require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :cursor, :board
  def initialize(board)
    @board  = board
    @cursor = Cursor.new([6, 3], board)
  end

  def render
    system('clear')
    puts "  Arrows to move cursor\n  Space bar to select/release\n\n"
    puts "  #{('a'..'h').to_a.join(' ')}"
    board.board.each_with_index do |row, i|
      row_number = (8 - i).to_s + ' '
      print row_number

      row.each_with_index do |col, j|
        colors = colorize_tile(i, j)
        print "#{col.symbol.black} ".colorize(colors)
      end
      puts
    end
  end

  def colorize_tile(i, j)
    if cursor.cursor_pos == [i, j] && cursor.selected
      # Selected piece cursor color
      bg_color = :light_black
    elsif cursor.cursor_pos == [i, j]
      # Default cursor color
      bg_color = :magenta
    elsif (i + j).odd?
      # Black queen's tile color
      bg_color = :light_cyan
    else
      # White queen's tile color
      bg_color = :light_white
    end
    { background: bg_color }
  end
end
