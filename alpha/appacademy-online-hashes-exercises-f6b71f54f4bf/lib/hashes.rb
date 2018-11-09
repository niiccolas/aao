# EASY

# -------
# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
  hash = Hash.new('')
  str.split(' ').each do |word|
    hash[word] = word.length
  end

  hash
end

# p word_lengths('Destitutus ventis remos adhibere')
# => {"Destitutus"=>10, "ventis"=>6, "remos"=>5, "adhibere"=>8}

# -------
# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
  hash.sort_by { |_int, value| value }.last[0]
end

# goats = {
#   'Waltz Frazier' => 10,
#   'Kobe Bryant' => 8,
#   'Wilt Chamberlain' => 13
#   }
# p greatest_key_by_val(goats) # => "Wilt Chamberlain"

# -------
# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result.
march = { rubies: 10, emeralds: 14, diamonds: 2 }
april = { emeralds: 27, moonstones: 5 }
def update_inventory(older, newer)
  newer.each { |key1, val1| older[key1] = val1 }
  older
end

# puts update_inventory(march, april)
# => { rubies: 10, emeralds: 27, diamonds: 2, moonstones: 5 }

# -------
# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
  count = Hash.new(0)
  word.chars.each { |char| count[char] += 1 }
  count
end

# puts letter_counts('dazzle') # => {"d"=>1, "a"=>1, "z"=>2, "l"=>1, "e"=>1}

# MEDIUM

# -------
# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
  count = Hash.new(0)
  arr.each { |char| count[char] += 1 }
  count.keys.to_a
end

# print my_uniq([7, 9, 6, 7, 7, 9]) # => [7, 9, 6]

# -------
# Define a method that, given an array of numbers, returns a hash with "even"
# and "odd" as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
  hash = Hash.new(0)
  numbers.each do |number|
    number.even? ? hash[:even] += 1 : hash[:odd] += 1
  end
  hash
end

# puts evens_and_odds([1,2,3,1,5])

# -------
# Define a method that, given a string, returns the most common vowel. Do
# not worry about ordering in the case of a tie. Assume all letters are
# lower case.
def most_common_vowel(string)
  most_common = Hash.new(0)
  string.chars.each do |char|
    most_common[char] += 1
  end

  most_common.sort_by { |_key, value| value }.last[0]
end

# puts most_common_vowel("eieeoaa") # => e
# HARD

# -------
# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12).
def fall_and_winter_birthdays(students)
  fw_people = students.keep_if { |_k, v| v >= 7 }.keys
  fw_people.combination(2).to_a
end

# students_with_birthdays = {
#   "Asher" => 6,
#   "Bertie" => 11,
#   "Dottie" => 8,
#   "Warren" => 9
# }

# print fall_and_winter_birthdays(students_with_birthdays)
# => [["Bertie", "Dottie"], ["Bertie", "Warren"], ["Dottie", "Warren"]]

# -------
# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula:
# number_of_species ** 2 *  smallest_population_size / largest_population_size

def biodiversity_index(specimens)
  # number_of_species ** 2 *  smallest_population_size / largest_population_size
  species = Hash.new(0)
  specimens.each { |el| species[el] += 1 }
  species.keys.length ** 2 * species.values.min / species.values.max

end

# puts biodiversity_index(["cat", "cat", "cat"]) # => 1
# puts biodiversity_index(["cat", "leopard-spotted ferret", "dog"]) # => 9

# -------
# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.

def can_tweak_sign?(normal_sign, vandalized_sign)
  norm_hash   = character_count(normal_sign)
  vandal_hash = character_count(vandalized_sign)

  vandal_hash.each { |k, v| return false unless norm_hash.key?(k) && norm_hash[k] >= v }
  true
end

def character_count(str)
  # No punctuation, no spaces, all downcase
  validated_str = str.gsub(/[[:punct:][:space:]]/,'').downcase
  validated_str.chars.each_with_object(Hash.new(0)) { |e, h| h[e] += 1 }
end

sign                = "MIGHTY MISSISSIPPI"
sign_vandalized     = "I MISS PIMS"
sign_vandalized_alt = "I MISS MY TASTY PIMS"

puts can_tweak_sign?(sign, sign_vandalized)     # => true
puts can_tweak_sign?(sign, sign_vandalized_alt) # => false
