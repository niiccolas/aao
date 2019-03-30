require_relative 'board'
require_relative 'ui'
require 'duplicate'
require 'set'

class SudokuSolver
  BOARD_POSITIONS = [*0..8].product([*0..8]).reverse

  def initialize(puzzle_file)
    @board        = Board.new(puzzle_file)
    @elapsed_time = Time.now
  end

  def solve
    recursive_solve
    UI.congratulate(@elapsed_time)
  end

  private

  def recursive_solve
    begin
      solve_until_no_moves_left
    rescue RuntimeError
      return false # BASE CASE 1: Exception raised when no possible moves found
    end
    return true if @board.solved? # BASE CASE 2: the board is solved

    empty_pos = ''
    BOARD_POSITIONS.each do |pos|
      empty_pos = pos if @board[*pos].value.nil?
    end

    potential_solutions(empty_pos).each do |solution|
      board_deep_copy    = duplicate(@board)
      @board[*empty_pos] = solution
      return true if recursive_solve == true

      @board = duplicate(board_deep_copy) # Undo recursive changes
    end
  end

  def solve_until_no_moves_left
    loop do
      changes_made = false
      BOARD_POSITIONS.each do |position|
        solution = potential_solutions(position)
        next unless solution
        raise 'No moves left' if solution.length.zero?

        if solution.length == 1
          @board[*position] = solution.first
          changes_made      = true
          @board.render
        end
      end

      break unless changes_made
    end
  end

  def potential_solutions(pos)
    return false if @board[*pos].value # Ignore positions holding a value

    row, col = pos
    Set.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) -
      row_solutions(row) -
      column_solutions(col) -
      square_solutions(row, col)
  end

  def row_solutions(row)
    @board.grid[row].map(&:value)
  end

  def column_solutions(col)
    @board.grid.transpose[col].map(&:value)
  end

  def square_solutions(row, col)
    row_start = (row / 3) * 3
    col_start = (col / 3) * 3
    # Reduce board to relevant third of rows
    square    = @board.grid[row_start...row_start + 3]
    # Reduce square to relevant third of columns
    square.map! { |sb_row| sb_row[col_start...col_start + 3] }

    square.flatten!.map!(&:value)
  end
end

if $PROGRAM_NAME == __FILE__
  SudokuSolver.new("./puzzles/#{ARGV[0]}").solve
end