##########################
# Loops, Arrays, Methods #
##########################

# Iterate through a string
def printChars(str)
  i = 0
  while i < str.length
    puts str[i]
    i += 1
  end
end


# Repeat a string n times
def repeater(n, str)
  i = 0
  while i < n
    puts str
    i += 1
  end
end
# repeater(3, ['Hey programmers','Whats for lunch?',''])


# Say hello to str
def sayHello(str)
  puts 'Hey, good to see you ' + str
end
# sayHello('Grace Hopper')


# Return the average of two nums
def calcAverage(n1, n2)
  return (n1 + n2) / 2.0
end


# Is a number positive, negative or zero?
def number_check(num)
  if num > 0
    return 'positive'
  elsif num < 0
    return 'negative'
  else
    p 'zero'
  end
end
# puts number_check(5)    # => 'positive'
# puts number_check(-2)   # => 'negative'
# puts number_check(0)    # => 'zero'


# Repeats 'hello' n times
def repeatHello(n)
  i = 0
  while i < n
    puts 'hello'
    i += 1
  end
end
# puts repeatHello(23)


# Count a's in a words
def count_a(word)
  counter = 0
  i = 0
  while i < word.length
    if word[i] == 'a' || word[i] == 'A'
      counter += 1
    end
    i += 1
  end
  return counter
end
# puts count_a('application')  # => 2
# puts count_a('bike')         # => 0
# puts count_a('Arthur')       # => 1
# puts count_a('Aardvark')     # => 3


# Count vowels in a word
def count_vowels(word)
  counter = 0
  i = 0
  while i < word.length
    if word[i] == 'a' ||
       word[i] == 'e' ||
       word[i] == 'i' ||
       word[i] == 'o' ||
       word[i] == 'u'
      counter += 1
    end
    i += 1
  end
  return counter
end
# puts count_vowels('bootcamp')  # => 3
# puts count_vowels('apple')     # => 2
# puts count_vowels('pizza')     # => 2


# Return num's factorial
def factorial(num)
  i = 1
  fact = i
  while i <= num
    fact *= i
    i += 1
  end
    return fact
end
# puts factorial(3) # => 6, because 1 * 2 * 3 = 6
# puts factorial(5) # => 120, because 1 * 2 * 3 * 4 * 5 = 120


# Reverse a word
def reverse(word)
  i = word.length - 1
  reversed = ''
  while i >= 0
    reversed += word[i]
    i -= 1
  end
  return reversed
end


# Palindrome checker
def isPalindrome(word)
  return word == reverse(word)
end
# puts isPalindrome('LAVALLIRE')

# The SHOVEL << operator
names = [
  'Liza',
  'Jing',
  'Yohann'
]
names << 'Nic'
names << 'Eunyce'
# p names


# Double each integer of an array
def doubler(arr)
  i = 0
  while i < arr.length
    arr[i] = arr[i] * 2
    i += 1
  end
  return arr
end
# p doubler([1,2,3,4,5])


# Add '!' to each element of an array & return it
def yell(arr)
  result = [];
  i = 0;
  while i < arr.length
    result[i] = arr[i] + '!';
    i += 1;
  end
  return result
end
# print yell(['hello', 'world'])
# puts
# print yell(['code', 'is', 'cool'] << 'strange')


# Good old fizzbuzz
def fizz_buzz(max)
  fb_arr = [];
  i = 1
  while i < max
    if !(i % 4 == 0 && i % 6 == 0) && (i % 4 == 0 || i % 6 == 0)
      fb_arr << i
    end
    i += 1
  end
  return fb_arr
end
# print fizz_buzz(20) # => [4, 6, 8, 16, 18]
# puts
# print fizz_buzz(13) # => [4, 6, 8]


# Yet another palindrome checker
def is_palindrome(str)
  return str == str.reverse
end
# puts is_palindrome('Brutecamp')


# Return initials of a name
def to_initials(name)
  initials = ''
  name_to_arr = name.split(' ')
  name_to_arr.each { |e| initials += e[0] }
  return initials
end
# p to_initials('Marie Curie')


# Returns name with first letters capitalized
def format_name(str)
  parts = str.split(' ')
  new_parts = []

  parts.each do |part|
    new_parts << part[0].upcase + part[1..-1].downcase
  end

  return new_parts.join(' ')
end
# puts format_name('chase WILSON') # => 'Chase Wilson'
# puts format_name('brian CrAwFoRd scoTT') # => 'Brian Crawford Scott'


# Name validator
# A name is valid is if satisfies all of the following:
# - contains at least a first name and last name, separated by spaces
# - each part of the name should be capitalized
#
# Hint: use str.upcase or str.downcase
# 'a'.upcase # => 'A'
def is_valid_name(str)
  split_name = str.split(' ')

  first_and_last_name = split_name.length > 1; # Has a first and last name ?
  capitalized = true; # Each part of the name is properly capitalized ?

  split_name.each do | word |
    capitalized = word[0] == word[0].upcase && word[1..-1] == word[1..-1].downcase # set capitalized to firt letter upcase? && remaining letters downcase?
  end

  return first_and_last_name && capitalized
end

# puts is_valid_name('Kush Patel')       # => true
# puts is_valid_name('Daniel')           # => false
# puts is_valid_name('Robert Downey Jr') # => true
# puts is_valid_name('ROBERT DOWNEY JR') # => false
# puts is_valid_name('Leet Koderrr')      # => true
# puts is_valid_name('LeEt KoDeRrr')      # => false


# Email validator
# For simplicity, we'll consider an email valid when it satisfies all of the following:
# - contains exactly one @ symbol
# - contains only lowercase alphabetic letters before the @
# - contains exactly one . after the @
def is_valid_email(str)
  split = str.split('@');
  numbers = '0123456789'

  if str.count('@') != 1 # Exit if str has more than one '@''
    return false
  end

  split[0].each_char do |c| # Exit if numeric character before the '@'
    if numbers.include?(c)
      return false
    end
  end

  is_lowercase = (split[0] == split[0].downcase)
  has_point = split[1].include?('.')
  return is_lowercase && has_point
end

# puts is_valid_email('avc@xy.z')         # => true
# puts is_valid_email('jdoe@gmail.com')   # => true
# puts is_valid_email('jdoe@g@mail.com')  # => false
# puts is_valid_email('jdoe42@gmail.com') # => false
# puts is_valid_email('jdoegmail.com')    # => false
# puts is_valid_email('az@email')         # => false


# Translate an array of str & nums into a string of str*num
def array_translate(array) # v2
  str = ''
  array.each_with_index do | el, i |
    if i % 2 == 0
      array[i + 1].times do
        str += array[i]
      end
    end
  end
  return str
end
# print array_translate(['Cat', 2, 'Dog', 3, 'Mouse', 1]); # => 'CatCatDogDogDogMouse'
# puts
# print array_translate(['red', 3, 'blue', 1]); # => 'redredredblue'
# puts


# Word reverser
def reverse_words(sent)
  split = sent.split(' ')
  reversed = []
  split.each do | word |
    reversed.push(word.reverse)
  end
  return reversed.join(' ')
end
# puts reverse_words('keep coding') # => 'peek gnidoc'
# puts reverse_words('simplicity is prerequisite for reliability') # => 'yticilpmis si etisiuqererp rof ytilibailer'


# Array rotator
def rotate_array(arr, num)
  num.times do
     arr.unshift(arr.pop())
  end
  return arr
end
# print rotate_array([ 'Matt', 'Danny', 'Mashu', 'Matthias' ], 1) # => [ 'Matthias', 'Matt', 'Danny', 'Mashu' ]
# puts
# print rotate_array([ 'a', 'b', 'c', 'd' ], 2) # => [ 'c', 'd', 'a', 'b' ]
# puts


# Pig latin translator
# Pig latin translation uses the following rules:
# - for words that start with a vowel, add 'yay' to the end
# - for words that start with a nonvowel, move all letters before the first vowel to the end of the word and add 'ay'
def pig_latin_word(word)
  vowels = 'aeiou'

  if vowels.include?(word[0])
    return word + 'yay'
  end

  word.each_char.with_index do | char, i |
    if vowels.include?(char)
      return word[i..-1] + word[0...i] + 'ay'
    end
  end
end
# puts pig_latin_word('apple')   # => 'appleyay'
# puts pig_latin_word('eat')     # => 'eatyay'
# puts pig_latin_word('banana')  # => 'ananabay'
# puts pig_latin_word('trash')   # => 'ashtray'


# Generate a nested array of arr's all possible combinations
def combinations(arr)
  pairs = []

  arr.each.with_index do |el1, i1|
    arr.each.with_index do |el2, i2|
      if i2 > i1
        pairs << [el1, el2]
      end
    end
  end
  return pairs
end
# print combinations(['a', 'b', 'c']); # => [ [ 'a', 'b' ], [ 'a', 'c' ], [ 'b', 'c' ] ]
# puts
# print combinations([0, 1, 2, 3]); # => [ [ 0, 1 ], [ 0, 2 ], [ 0, 3 ], [ 1, 2 ], [ 1, 3 ], [ 2, 3 ] ]
# puts


# Return n opposites present in an array
def opposite_count(nums)
  count = 0
  nums.each.with_index do | num1, i1 |
    nums.each.with_index do | num2, i2 |
      if (num1 + num2) == 0 && i2 > i1
        count += 1
      end
    end
  end
  return count
end
# puts opposite_count([ 2, 5, 11, -5, -2, 7 ]) # => 2
# puts opposite_count([ 21, -23, 24 -12, 23 ]) # => 1


# Flatten & sum nested arrays
def two_d_sum(arr)
  sum = 0
  arr.each do | el1 |
    el1.each do | el2|
      sum = sum + el2
    end
  end
  puts
  return sum
end
# array_1 = [
#   [4, 5],
#   [1, 3, 7, 1]
# ]
# puts two_d_sum(array_1)    # => 21

# array_2 = [
#   [3, 3],
#   [2],
#   [2, 5]
# ]
# puts two_d_sum(array_2)    # => 15


def two_d_translate(arr)
  one_d_arr = []
  arr.each do | outer |
    outer.each.with_index do | inner, i |
      if i == 0
        outer[1].times do
          one_d_arr << inner
        end
      end
    end
  end
  return one_d_arr
end
# arr_1 = [
#   ['boot', 3],
#   ['camp', 2],
#   ['program', 0]
# ]
# print two_d_translate(arr_1) # => [ 'boot', 'boot', 'boot', 'camp', 'camp' ]