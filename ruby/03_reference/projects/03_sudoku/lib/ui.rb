class UI
  def initialize(grid, squares)
    @grid_length = grid.length
    @squares     = squares
  end

  def draw(item)
    return top_border    if item == :first_row
    return numbers(item) if item.is_a? Array

    bottom_border        if item == 8
    middle_border        if [2, 5].include?(item)
    puts
  end

  def numbers(row)
    n_col_borders = (@grid_length / @squares) + 1
    col_indices   = (0..n_col_borders * @squares).step(n_col_borders).to_a

    col_indices.each { |i| row.insert(i, '│ ') }

    print row.join(' ').chop
  end

  def verticals
    '│ '
  end

  def left_vertical
    print '│ '
  end

  def top_border
    line = '─' * 8
    print "\n┌#{line}┬#{line}┬#{line}┐\n"
  end

  def bottom_border
    line = '─' * 8
    print "\n└#{line}┴#{line}┴#{line}┘\n"
  end

  def middle_border
    line = '─' * 8
    print "\n├#{line}┼#{line}┼#{line}┤"
  end
end