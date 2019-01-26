class Piece
  attr_reader :color, :board, :pos
  def initialize(color, board, position)
    @color = color
    @board = board
    @pos   = position
  end

  def pos=(val)
    @pos = val
  end

  def symbol
    symbol
  end

  def empty?(pos)
    # board[pos]
    brd[pos].instance.class == NullPiece
  end

  private

  def move_into_check?(end_pos)

  end
end