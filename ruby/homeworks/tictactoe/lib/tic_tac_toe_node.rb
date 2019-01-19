require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return board.won? && board.winner != evaluator
    end

    if next_mover_mark == evaluator # player's turn
      children.all? { |node| node.losing_node?(evaluator) }
    else # opponent's turn
      children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if board.over?
      return board.won? && board.winner == evaluator
    end

    if next_mover_mark == evaluator # player's turn
      children.any? { |node| node.winning_node?(evaluator) }
    else # opponent's turn
      children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    positions = [0, 1, 2].product([0, 1, 2])
    positions.each do |position|
      next unless board.empty?(position)

      new_board = board.dup
      new_board[position] = self.next_mover_mark
      next_mover_mark = (self.next_mover_mark == :x ? :o : :x)

      children << TicTacToeNode.new(new_board, next_mover_mark, position)
    end

    children
  end
end
