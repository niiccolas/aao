class Piece
  attr_reader :color, :board
  attr_accessor :pos
  #, :pos
  def initialize(color, board, position)
    @color = color
    @board = board
    @pos   = position
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

  private

  def move_into_check?(end_pos)

  end
end