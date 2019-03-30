module SlidingPiece
  DIAGONAL_DIR = [
    [-1, -1],
    [-1,  1],
    [ 1, -1],
    [ 1,  1]
  ].freeze

  PERPENDICULAR_DIR = [
    [-1,  0],
    [ 1,  0],
    [ 0, -1],
    [ 0,  1]
  ].freeze

  def diagonal_dir
    DIAGONAL_DIR
  end

  def perpendicular_dir
    PERPENDICULAR_DIR
  end

  def moves
    moves = []

    # calling each different sliding piece move partern
    move_dirs.each do |dx, dy|
      moves.concat(grow_unblocked_moves_in_dir(dx, dy))
    end

    # array of positions a Piece can move to
    moves
  end

  private

  def move_dirs
    # method overwritten by subclass!
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    cur_x, cur_y = pos
    moves        = []

    loop do
      cur_x += dx
      cur_y += dy
      pos    = [cur_x, cur_y]

      break unless board.valid_pos?(pos)

      if board.empty?(pos) # move to an empty space
        moves << pos
      else # take opponent's piece
        moves << pos if board[pos].color != color

        break # stop when blocked by piece
      end
    end
    moves
  end
end
