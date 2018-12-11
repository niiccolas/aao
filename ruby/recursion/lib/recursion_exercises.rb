# Warmup
# Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive
def range(start_num, end_num)
  return [] if end_num <= start_num

  [start_num] + range(start_num + 1, end_num)
end

# Write a method that sums an array of integers
# Recursively...
def sum_array_recursive(arr)
  return arr[0] if arr.length == 1

  arr[0] + sum_array_recursive(arr[1..-1])
end

# .. and iteratively
def sum_array_iterative(arr)
  arr.reduce(:+)
end
