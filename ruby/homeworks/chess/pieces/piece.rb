class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, position)
    @color = color
    @board = board
    @pos   = position

    board.add_piece(self, pos)
  end

  def to_s
    " #{symbol}"
  end

  def symbol
    # superseeded by subclasses
    raise NotImplementedError
  end

  def empty?
    false
  end

  def valid_moves
    moves.reject { |mov_pos| move_into_check?(mov_pos) }
  end

  private

  def move_into_check?(end_pos)
    twin_board = board.dup
    twin_board.move_piece!(pos, end_pos)
    twin_board.in_check?(color)
  end
end
