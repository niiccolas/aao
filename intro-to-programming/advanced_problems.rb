# -------
# For a given sentence,
# return an array of sentence's words including the letter 'o'
def o_words(sentence)
  words = sentence.split(' ')
  return words.select { | val | val.include?('o') }
end

# print o_words('How did you do that?') #=> ['How', 'you', 'do']
# puts

# -------
# For a given string and char,
# return last index of char in string
def last_index(str, char)
  i = 0
  str.each_char.with_index do |ch,ind|
   if ch == char
     i = ind
   end
  end
  return i
end

# puts last_index('abca', 'a')       #=> 3
# puts last_index('mississipi', 'i') #=> 9
# puts last_index('octagon', 'o')    #=> 5
# puts last_index('programming', 'm')#=> 7

# -------
# For a given sentence,
# return sentence's word having the most vowels
def most_vowels(sentence)
  words = sentence.split(' ')
  vowels = 'aeiou'
  words_hash = {}

  words.each do |word|
    char_count = 0
    word.each_char do |char|
      if vowels.include?(char)
        char_count += 1
      end
    end
    words_hash[word] = char_count
  end

  sorted_hash = words_hash.sort_by { |k, v| v }
  return sorted_hash[sorted_hash.length - 1][0]
end

# print most_vowels('what a wonderful life') #=> 'wonderful'

# -------
# Is given number num a prime number?
# https://en.wikipedia.org/wiki/Prime_number‎
def is_prime(num)
  if num < 2
    return false
  end

  (2...num).each do |factor|
    if num % factor == 0
      return false
    end
  end

  return true
end

# puts prime?(2)  #=> true
# puts prime?(11) #=> true
# puts prime?(4)  #=> false
# puts prime?(-5) #=> false

# -------
# For a given array 'numbers',
# return an array of the primes in 'numbers'
def pick_primes(numbers)
  numbers.select { | n | is_prime(n) }
end

# print pick_primes(2...100) #=> [2, 3, 5]
# puts
# print pick_primes([101, 20, 103, 2017]) #=> [101, 103, 2017]
# puts

# -------
# For a given number num,
# return an array containing all of the prime factors of num
def prime_factors(num)
  primes = (2..num).select { | n | isprime?(n) }
  primes.select { |prime| num % prime == 0 }
end

# print prime_factors(24) #=> [2, 3]
# puts
# print prime_factors(60) #=> [2, 3, 5]
# puts

# -------
# For a given array of numbers,
# return each element's greatest factor
def greatest_factor_array(arr)
  arr.map do |el|
    if is_prime(el)
      el
    elsif el % 2 == 0
      el / 2
    else
      el
    end
  end
end

# print greatest_factor_array([16, 7, 9, 14]) # => [8, 7, 9, 7]
# puts
# print greatest_factor_array([30, 3, 24, 21, 10]) # => [15, 3, 12, 21, 5]
# puts

# -------
# Is num resulting from the product of num x num?
# aka "perfect square" https://en.wikipedia.org/wiki/Perfect_square
def perfect_square?(num)
  (1..num).each do |p|
    if p * p == num
      return true
    end
  end
  return false
end

# puts perfect_square?(9)   #=> true
# puts perfect_square?(12)  #=> false

# -------
# For two given integers 'start' and 'length'
# return an array containing 'length' elements where
# first element is 'start' and the following one are
# the summation of the previous one
# https://en.wikipedia.org/wiki/Summation
def summation_sequence(start, length)
  sequence = [start]
  while sequence.length < length
    sequence << summation(sequence[-1])
  end
  return sequence
end

# Helper method for summation_sequence
def summation(num)
  sum = 0
  (0..num).each do |v|
    sum += v
  end
  return sum
end

# print summation_sequence(3, 4) # => [3, 6, 21, 231]
# print summation_sequence(5, 3) # => [5, 15, 120]

# -------
# The Fibonacci sequence is a sequence of numbers
# whose first and seconds elements are 1. Going further,
# each element is the sum of the two preceding ones
# https://en.wikipedia.org/wiki/Fibonacci_number
def fibonacci(length)
  if length == 0
    return []
  elsif length == 1
    return [1]
  end
  sequence = [1,1]

  (length - 2).times do
    sequence << sequence[-1] + sequence[-2]
  end

  return sequence
end

# print fibonacci(0) # => []
# puts
# print fibonacci(1) # => [1]
# puts
# print fibonacci(6) # => [1, 1, 2, 3, 5, 8]
# puts
# print fibonacci(8) # => [1, 1, 2, 3, 5, 8, 13, 21]
# puts

# -------
# For a given string 'str' and integer 'num',
# shift each 'str' letter by 'num' characters in the alphabet
# aka Ceasar Cipher https://en.wikipedia.org/wiki/Caesar_cipher
def caesar_cipher(str, num)
  alphabet = 'abcdefghijklmnopqrstuvwxyz'

  str.each_char.with_index do |char, i|
    shift = alphabet.index(char) + num # shifting num chars in the alphabet
    if shift > 26 # restart at 0 after index 26
      shift -= 26
    end
    str[i] = alphabet[shift]
  end

  str
end

# puts caesar_cipher('apple', 1)    #=> 'bqqmf'
# puts caesar_cipher('bootcamp', 2) #=> 'dqqvecor'
# puts caesar_cipher('zebra', 4)    #=> 'difve'

# -------
# For a given string, return a string where every vowel becomes the next vowel
def vowel_cipher(string)
  vowels = 'aeiou'
  string.each_char.with_index do |char, i|
    if vowels.include?(char)
      vowel_index = vowels.index(char)
      string[i] = vowels[(vowel_index + 1) % vowels.length]
    end
  end
  string
end

# puts vowel_cipher('bootcamp') #=> buutcemp
# puts vowel_cipher('paper cup') #=> pepir cap

# -------
# For a given string, return the number of times that a letter repeats twice
def double_letter_count(string)
  repeating_letters = 0
  string.each_char.with_index do |char, i|
    if string[i] == string[i + 1]
      repeating_letters += 1
    end
  end
  return repeating_letters
end

# puts double_letter_count('the jeep rolled down the hill') #=> 3
# puts double_letter_count('bootcamp') #=> 1

# -------
# For a given array, return an array of sums of adjacent numbers
def adjacent_sum(arr)
  sum = []
  arr.each_with_index do |el, index|
    if index == arr.length - 1
      return sum
    end
    sum << arr[index] + arr[index + 1]
  end
end

# print adjacent_sum([3, 7, 2, 11]) #=> [10, 9, 13], because [ 3+7, 7+2, 2+11 ]
# puts
# print adjacent_sum([2, 5, 1, 9, 2, 4]) #=> [7, 6, 10, 11, 6], because [2+5, 5+1, 1+9, 9+2, 2+4]

# -------
# For a given array of numbers 'base',
# return a 2D array pyramid with 'base' as last element.
# each level of the pyramid is constructed with
# adjacent_sum of the level below.
def pyramid_sum(base)
  pyramid = [base]
  while base.length > 1 # we'll take out from 'base' to feed 'pyramid'
    base = adjacent_sum(base)
    pyramid.unshift(base)
  end
  pyramid
end

# print pyramid_sum([1, 4, 6]) #=> [[15], [5, 10], [1, 4, 6]]
# puts
# print pyramid_sum([3, 7, 2, 11]) #=> [[41], [19, 22], [10, 9, 13], [3, 7, 2, 11]]

# -------
# For a given array of numbers arr,
# return half the sum of arr's elements
def all_else_equal(arr)
  arr_sum = arr.inject { |mem, var| mem + var }
  if arr.index(arr_sum / 2)
    return arr[arr.index(arr_sum / 2)]
  end
  nil
end

# p all_else_equal([2, 4, 3, 10, 1]) #=> 10, because the sum of all elements is 20
# p all_else_equal([6, 3, 5, -9, 1]) #=> 3, because the sum of all elements is 6
# p all_else_equal([1, 2, 3, 4])     #=> nil, because the sum of all elements is 10 and there is no 5 in the array

# -------
# For two given words 'word1' and 'word2',
# return a boolean indicating if the words are anagrams of each other
# https://en.wikipedia.org/wiki/Anagram
def anagrams?(word1, word2)
  w1 = Hash.new(0)
  word1.each_char do |char|
    w1[char] += 1
  end
  w2 = Hash.new(0)
  word2.each_char do |char|
    w2[char] += 1
  end
  return w1 == w2
end

# puts anagrams?('cat', 'act')          #=> true
# puts anagrams?('restful', 'fluster')  #=> true
# puts anagrams?('cat', 'dog')          #=> false
# puts anagrams?('boot', 'bootcamp')    #=> false

# -------
# For a given string 'sentence', return a string where
# each of 'sentence' word begins with its first vowel
def consonant_cancel(sentence)
  words = sentence.split(' ')
  new_words = words.map { |word| del_before_vowel(word) }
  return new_words.join(' ')
end

# Helper method for consonant_cancel()
def del_before_vowel(word)
  vowels = 'aeiou'
  word.each_char.with_index do |char, i|
      if vowels.include?(char)
        return word.slice(i, word.length)
      end
  end
end

# puts consonant_cancel('down the rabbit hole') #=> 'own e abbit ole'
# puts consonant_cancel('writing code is challenging') #=> 'iting ode is allenging'

# -------
# For a given string, return a collapsed version of that string
def same_char_collapse(str)
  while has_double_adjacent(str)
    str.each_char.with_index do |char, i|
      if str[i] == str[i + 1]
        str[i..i + 1] = ''
        break
      end
    end
  end
  return str
end

# Helper method for same_char_collapse()
def has_double_adjacent(string)
  string.each_char.with_index do |char, i|
    if string[i] == string[i + 1]
      return true
    end
  end
  false
end

# puts same_char_collapse('zzzxaaxy')   #=> 'zy'
# 'zzzxaaxy' -> 'zxaaxy' -> 'zxxy' -> 'zy'
