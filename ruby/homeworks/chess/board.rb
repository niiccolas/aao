require_relative 'pieces'

class Board
  BOARD_POSITIONS = [*0..7].product([*0..7])
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8, NullPiece.instance) }
    populate_board
  end

  def populate_board
    %i[white black].each do |color|
      populate_main_pieces(color)
      populate_pawn_pieces(color)
    end
  end

  def populate_main_pieces(color)
    main_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    i = color == :white ? 7 : 0
    main_pieces.each_with_index do |main_piece, j|
      main_piece.new(color, self, [i, j])
    end
  end

  def populate_pawn_pieces(color)
    i = color == :white ? 6 : 1
    (0..7).each { |j| Pawn.new(color, self, [i, j]) }
    end
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError.new("No piece in this location") if self[start_pos].is_a? NullPiece
    raise ArgumentError.new("This location is not on the board") unless valid_pos?(end_pos)
    # raise ArgumentError.new("Location already occupied or not on the board") unless valid_pos?(end_pos)

    self[start_pos] = NullPiece.new
    self[end_pos]   = Piece.new
  end

  def valid_pos?(pos)
    BOARD_POSITIONS.include?(pos) #&& self[pos].is_a?(NullPiece)
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @board[row][col] = val
  end
end
