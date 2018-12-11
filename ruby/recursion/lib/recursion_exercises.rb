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

# Exponentiation
# Write two versions of exponent that use two different recursions: Note that for recursion 2, you will need to square the results of exp(b, n / 2) and (exp(b, (n - 1) / 2).

def exponent_v1(b, n, counter = 0)
  return 1 if n.zero?

  b * exponent_v1(b, n - 1)
end

def exponent_v2(b, n)
  return 1 if n.zero?

  if n.odd?
    b * square(exponent_v2(b, (n - 1) / 2))
  else
    square(exponent_v2(b, n / 2))
  end
end

# helper method for exponent_v2
def square(num)
  num * num
end

# Deep dup
# Using recursion and the is_a? method, write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

class Array
  def deep_dup
    return self if self.none? { |el| el.is_a? Array }

    duplicate = []
    self.each do |el|
      if el.is_a? Array
        duplicate << Array.new(el).deep_dup
      else
        duplicate << el
      end
    end

    duplicate
  end
end

# Fibonacci
# Write a recursive and an iterative Fibonacci method. The method should take in an integer n and return the first n Fibonacci numbers in an array.

# Iterative Fibonacci
def fibonacci(n, fib_sequence = [0, 1])
  return [0]    if n.zero?
  return [0, 1] if n == 1

  (n - 2).times do
    fib_sequence << fib_sequence[-1] + fib_sequence[-2]
  end
  fib_sequence
end

# Recursive Fibonacci
def fibr(n)
  return [0,1] if n <= 2

  sequence = fibr(n - 1)
  sequence << sequence[-2] + sequence[-1]
  sequence
end

# Binary Search
# Write a recursive binary search: bsearch(array, target). Note that binary search only works on sorted arrays. Make sure to return the location of the found object (or nil if not found!). Hint: you will probably want to use subarrays.

def bsearch(array, target)
  return nil unless array.include?(target)

  midpoint = array.length / 2
  return midpoint if target == array[midpoint]

  if target < array[midpoint]
    bsearch(array[0...midpoint], target)
  elsif target > array[midpoint]
    midpoint += bsearch(array[midpoint + 1..-1], target) + 1
  end
end
