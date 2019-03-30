require_relative 'min_max_stack_queue'

# Naive approach
# O(n * m) linear time complexity
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

# O(n) linear time complexity
def better_windowed_max_range(arr, window_size)
  queue = MinMaxStackQueue.new
  max_range = nil

  arr.each do |el|
    queue.enqueue(el)
    queue.dequeue if queue.size > window_size

    if queue.size == window_size
      current_range = queue.max - queue.min
      max_range = current_range if max_range.nil? || current_range > max_range
    end
  end

  max_range
end
