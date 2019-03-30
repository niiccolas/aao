module SteppingPiece
  def moves
    move_diffs.each_with_object([]) do |(dx, dy), moves|
      cur_x, cur_y = pos
      pos = [(cur_x + dx), (cur_y + dy)]
      next unless board.valid_pos?(pos)

      # Add pos to the moves array (object):
      # If pos is empty
      if board.empty?(pos)
        moves << pos
      # If pos is occupied by opponent
      elsif board[pos].color != color
        moves << pos
      end
    end
  end

  private

  def move_diffs
    # method overwritten by subclass!
    raise NotImplementedError
  end
end
