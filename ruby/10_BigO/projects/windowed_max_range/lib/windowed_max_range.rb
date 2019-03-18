# Naive approach
# O(n) linear time complexity
def windowed_max_range(arr, window_size)
  max_range = nil
  num_windows = (arr.length - window_size) + 1

  num_windows.times do |i|
    window        = arr.slice(i, window_size)
    current_range = window.max - window.min

    max_range = current_range if max_range.nil? || current_range > max_range
  end

  max_range
end
