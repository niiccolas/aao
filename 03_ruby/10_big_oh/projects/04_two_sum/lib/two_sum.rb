# Brute Force
# O(n^2) quadratic time complexity
# O(1) constant space complexity, no auxiliary structures are created
def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |num1, i|
    arr[i..-1].each do |num2|
      next if num1 == num2

      return true if (num1 + num2) == target_sum
    end
  end

  false
end

# Sorting and Binary Search
# O(n log n) log-linear time complexity
# O(n) linear space complexity
def okay_two_sum?(arr, target_sum)
  arr.sort!
  arr.each_with_index do |num, i|
    match_index = arr.bsearch_index do |value|
      (target_sum - num) <=> value
    end

    return true if match_index && match_index != i
  end

  false
end

# Hash map
# O(n) linear time complexity
# O(n) linear space complexity
def two_sum?(arr, target_sum)
  summands = {}

  arr.each do |num|
    return true if summands[target_sum - num]

    summands[num] = true
  end

  false
end

# Hash map, returning the indices if true
# O(n) linear time complexity
# O(n) linear space complexity
def two_sum_indices?(arr, target_sum)
  summands = {}

  arr.each_with_index do |num, i|
    summand = target_sum - num
    return [target_sum[summand], i] if summands.key?(summand)

    summands[num] = i
  end

  false
end
