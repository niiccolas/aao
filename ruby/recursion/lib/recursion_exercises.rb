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
