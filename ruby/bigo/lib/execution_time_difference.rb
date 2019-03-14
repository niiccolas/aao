# O(n^2) quadratic time complexity
# O(1) constant space complexity
def my_min_quadratic(arr)
  arr.each do |num1|
    smallest = true
    arr.each do |num2|
      smallest = false if num1 > num2
    end

    return num1 if smallest
  end
end

# O(n) linear time complexity
# O(1) constant space complexity
def my_min_linear(arr)
  min_num = arr.first
  arr.each { |num| min_num = num if num < min_num }

  min_num
end

# O(n^2) quadratic time complexity
def largest_contiguous_subsum_quadratic(arr)
  subsums = []

  arr.each_index do |i|
    arr.each_index do |j|
      subsums << arr[i..j].reduce(:+) unless arr[i..j].empty?
    end
  end

  subsums.max
end

# O(n) linear time complexity
# O(1) constant space complexity
# Using Kadane's algorithm https://en.wikipedia.org/wiki/Maximum_subarray_problem#Kadane's_algorithm
def largest_contiguous_subsum_linear(arr)
  largest = arr.first
  current = arr.first

  arr[1..-1].each do |num|
    current = [(current + num), num].max
    largest = current if current > largest
  end

  largest
end
