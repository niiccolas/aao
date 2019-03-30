# EASY

# Return the argument with all its lowercase characters removed.
def destructive_uppercase(str)
  (str.chars - str.downcase.chars).join
end

# Return the middle character of a string. Return the middle two characters if
# the word is of even length, e.g. middle_substring("middle") => "dd",
# middle_substring("mid") => "i"
def middle_substring(str)
  mid = str.length / 2

  str.length.even? ? str[mid - 1..mid] : str[mid]
end

# Return the number of vowels in a string.
def num_vowels(str)
  str.scan(/[aeiou]/).count
end

# Return the factoral of the argument (num). A number's factorial is the product
# of all whole numbers between 1 and the number itself. Assume the argument will
# be > 0.
def factorial(num)
  (1..num).reduce(&:*)
end

# MEDIUM

# Write your own version of the join method. separator = "" ensures that the
# default seperator is an empty string.
def my_join(arr, separator = '')
  arr.each.with_object('') do |el, joined|
    el == arr.last ? (joined << el) : (joined << el + separator)
  end
end

# Write a method that converts its argument to weirdcase, where every odd
# character is lowercase and every even is uppercase, e.g.
# weirdcase("weirdcase") => "wEiRdCaSe"
def weirdcase(str)
  str.chars.map.with_index do |el, i|
    i.even? ? el.downcase : el.upcase
  end.join
end

# Reverse all words of five more more letters in a string. Return the resulting
# string, e.g., reverse_five("Looks like my luck has reversed") => "skooL like
# my luck has desrever")
def reverse_five(str)
  str.split.map do |word|
    word.length >= 5 ? word.reverse : word
  end.join(' ')
end

# Return an array of integers from 1 to n (inclusive), except for each multiple
# of 3 replace the integer with "fizz", for each multiple of 5 replace the
# integer with "buzz", and for each multiple of both 3 and 5, replace the
# integer with "fizzbuzz".
def fizzbuzz(n)
  (1..n).map do |num|
    next 'fizzbuzz' if (num % 3).zero? && (num % 5).zero?
    next 'fizz'     if (num % 3).zero?
    next 'buzz'     if (num % 5).zero?

    num
  end
end

# HARD

# Write a method that returns a new array containing all the elements of the
# original array in reverse order.
def my_reverse(arr)
  arr.each.with_object([]) do |el, reversed|
    reversed.unshift(el)
  end
end

# Write a method that returns a boolean indicating whether the argument is
# prime.
def prime?(num)
  return false if num <= 1

  # Other than by 1 and itself, a prime number is not evenly divisible
  (2...num).none? { |divisor| (num % divisor).zero? }
end

# Write a method that returns a sorted array of the factors of its argument.
def factors(num)
  (1..num).select { |el| (num % el).zero? }
end

# Write a method that returns a sorted array of the prime factors of its argument.
def prime_factors(num)
  factors(num).select { |factor| prime?(factor) }.sort
end

# Write a method that returns the number of prime factors of its argument.
def num_prime_factors(num)
  prime_factors(num).count
end

# EXPERT

# Return the one integer in an array that is even or odd while the rest are of
# opposite parity, e.g. oddball([1,2,3]) => 2, oddball([2,4,5,6] => 5)
def oddball(arr)
  majority_of_odds = arr.select(&:odd?).count > 1

  majority_of_odds ? arr.find(&:even?) : arr.find(&:odd?)
end
