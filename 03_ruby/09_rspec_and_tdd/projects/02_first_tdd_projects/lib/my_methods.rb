def my_uniq(dups_arr)
  dups_arr.each_with_object([]) { |el, arr| arr << el unless arr.include?(el) }
end

def two_sum(arr)
  arr.count.times.with_object([]) do |i, pairs|
    (i...arr.length).each do |j|
      pairs << [i, j] if (arr[i] + arr[j]).zero? && i != j
    end
  end
end

def my_transpose(grid)
  (0...grid.size).each.with_object(Array.new(grid.size) { [] }) do |i, transposed|
    (0...grid.size).each do |j|
      transposed[j][i] = grid[i][j]
    end
  end
end

def stock_picker(arr)
  raise 'Stock is crashing, do not buy' if arr == arr.sort { |a, b| b <=> a }

  profitable_buy  = arr.index(arr.min)
  profitable_sell = arr.index(arr[profitable_buy..-1].max)
  [profitable_buy, profitable_sell]
end
