# Given a list of integers, find the smallest number in the list

# Phase I
# First, write a function that compares each element to every other element of the list. Return the element if all other elements in the array are larger.

# O(n^2) quadratic time complexity:
def my_min_quadratic(arr)
  arr.each do |num1|
    smallest = true
    arr.each do |num2|
      next if num1 == num2

      smallest = false if num1 > num2
    end

    return num1 if smallest
  end
end
