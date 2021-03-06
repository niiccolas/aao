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
  return arr[0] if arr.length == 1

  arr.reduce(:+)
end

# Exponentiation
# Write two versions of exponent that use two different recursions: Note that for recursion 2, you will need to square the results of exp(b, n / 2) and (exp(b, (n - 1) / 2).

def exponent_v1(base, exponent)
  return 1 if exponent.zero?

  base * exponent_v1(base, exponent - 1)
end

def exponent_v2(base, exponent)
  return 1 if exponent.zero?

  if exponent.odd?
    base * square(exponent_v2(base, (exponent - 1) / 2))
  else
    square(exponent_v2(base, exponent / 2))
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
def fibonacci(num)
  return []  if num.zero?
  return [0] if num <= 1

  (num - 2).times.with_object([0, 1]) do |_el, arr|
    arr << arr[-1] + arr[-2]
  end
end

# Recursive Fibonacci
def fibr(num)
  if num <= 2
    [0, 1].take(num)
  else
    sequence = fibr(num - 1)
    sequence << sequence[-2] + sequence[-1]
  end
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

# Merge Sort
# Implement a method merge_sort that sorts an Array:
def merge_sort(arr)
  return nil if arr.empty?
  return arr if arr.length <= 1

  midpoint = arr.length / 2
  left     = merge_sort(arr[0...midpoint])
  right    = merge_sort(arr[midpoint..-1])

  merge(left, right)
end

# merge helper method for merge_sort
def merge(left, right)
  if left.empty?
    right
  elsif right.empty?
    left
  elsif left.first < right.first
    [left.first] + merge(left[1..-1], right)
  else
    [right.first] + merge(left, right[1..-1])
  end
end

# Array Subsets
# Write a method subsets that will return all subsets of an array

def subsets(arr)
  return [[]] if arr.empty?

  sets = subsets(arr[0...-1])
  sets + sets.map { |num| num + [arr.last] }
end

# Permutations
# Write a recursive method permutations(array) that calculates all the permutations of the given array.

def permutations(array)
  # Base case
  return [array] if array.length <= 1

  # Remove the first element of array while saving it
  # Ex. if arr = [1,2,3] => first = 1, arr = [2,3]
  first = array.shift

  # Recursively call permutations on the array that is now
  # one element shorter thanks to first = array.shift
  # This ensures that at some point,
  # we'll hit the base case of array.lenght <= 1
  perms = permutations(array)

  # Store the permutations for each stack frame
  total_permutations = []

  # Once we've hit the base case of [[n]],
  # iterate thru each element of perms
  perms.each do |perm|
    # for each permutation's index,
    (0..perm.length).each do |i|
      start_to_i = perm[0...i]
      i_to_end   = perm[i..-1]
      # depending on the current index, concat first element
      # before current perm
      # in the middle of current perm
      # after current perm
      total_permutations << start_to_i + [first] + i_to_end
    end
  end

  # Return the permutations for each stack frame
  total_permutations
end

# Make Change
# Create a method that makes change for a given amount
# using as default the 25, 10, 5 and 1 cent coins of the US dollar.
# Another system of coins can be passed to the method.

def make_change_iterative(amount, coins = [25, 10, 5, 1])
  coins = coins.sort.reverse # Make sure coins are in descending order
  change = []
  until change.sum == amount
    change << coins.detect { |coin| (change.sum + coin) <= amount }
  end

  change
end

# Recursive and greedy implementation
def greedy_make_change(amount, coins = [25, 10, 5, 1])
  # Each recursive call will take for amount the
  # substraction of (amount - largest possible coin).
  # As soon as, after substraction, amount is equal to
  # any of the coins, we've hit the base case
  return [amount] if coins.include?(amount)

  largest_coin = coins.detect { |coin| coin <= amount }
  [largest_coin] + greedy_make_change(amount - largest_coin, coins)
end

# Recursive implementation returning the least amount of coins
def make_better_change(amount, coins = [25, 10, 5, 1], possible_change_options = [])
  coins.each do |coin|
    possible_change_options << [coin] + greedy_make_change(amount - coin, coins)
  end
  possible_change_options.sort_by(&:length).first
end
