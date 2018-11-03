# Calculator helper methods
def add(num1, num2)
  num1 + num2
end

def subtract(num1, num2)
  num1 - num2
end

def sum(arr)
  arr.length.zero? ? 0 : arr.inject(:+)
end

# Bonus methods
def multiply(num1, num2 = nil)
  return num1.inject(:*) if num1.is_a? Array

  num1 * num2
end

def power(num1, num2)
  num1**num2
end

# The factorial of a non-negative integer int
# is the product of all positive integers <= int
# eg. factorial(5) = 1 x 2 x 3 x 4 x 5 = 120
# By convention, the factorial of 0 is 1.
def factorial(int)
  return 1 if int.zero?
  multiply((1..int.abs).to_a)
end