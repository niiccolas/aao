require_relative 'piece'

class Board
  BOARD_POSITIONS = [*0..7].product([*0..7])
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) {} }
    populate_board
  end

  def populate_board
    BOARD_POSITIONS.each do |position|
      if (2..5).cover? position.first
        # from row 2 to 5, populate using NullPiece instances
        self[position] = NullPiece.new
      else
        self[position] = Piece.new
      end
    end
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError.new("No piece in this location") if self[start_pos].is_a? NullPiece
    raise ArgumentError.new("Location already occupied or not on the board") unless valid_pos?(end_pos)

    self[start_pos] = NullPiece.new
    self[end_pos]   = Piece.new
  end

  def valid_pos?(pos)
    BOARD_POSITIONS.include?(pos) && self[pos].is_a?(NullPiece)
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @board[row][col] = val
  end

  def render
    board.each do |row|
      row.each do |col|
        print col.symbol + ' '
      end
      puts
    end
  end
end
