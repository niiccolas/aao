require_relative 'piece'

class Pawn < Piece
  def symbol
    color == :white ? '♙' : '♟'
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    row = pos[0]
    [1, 6].include? row
  end

  def forward_dir
    color == :white ? -1 : 1
  end

  def forward_steps
    i, j     = pos
    one_step = [i + forward_dir, j]
    return [] unless board.valid_pos?(one_step) && board.empty?(one_step)

    steps     = one_step
    two_steps = [i + 2 * forward_dir, j]

    steps << two_steps if at_start_row? && board.empty?(two_steps)
    steps
  end

  def side_attacks
    i, j = pos
    side_moves = [
      [i + forward_dir, j - 1], [i + forward_dir, j + 1]
    ]

    side_moves.select do |side_move|
      next false unless board.valid_pos?(side_move)
      next false if     board.empty?(side_move)

      opponents_piece = board[side_move]
      opponents_piece && opponents_piece.color != color
    end
  end
end
