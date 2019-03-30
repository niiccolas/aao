# -------
# Defining a hash literal
pizza = {
  'toppings' => 'Cherry tomatoes',
  'crust' => 'Classic',
  'price' => 12.99,
  'is_tasty' => true
}

# pizza.each_key do | k |
#   puts k + ':'
#   puts pizza[k]
#   puts '-----'
# end

# pizza.each do |key, value|
#   puts key
#   puts value
# end

# p pizza['hey'] # nil
# p pizza['crust'] # 'Classic'

# -------
# Double the hash key 'age'
def get_double_age(hash)
  return hash['age'] *= 2
end

# puts get_double_age({'name'=>'App Academy', 'age'=>5}) # => 10
# puts get_double_age({'name'=>'Ruby', 'age'=>23})       # => 46

# -------
# Hash representation of each word's length
def word_lengths(sentence)
  hash = {}
  split = sentence.split(' ')
  split.each do | key |
    hash[key] = key.length
  end
  return hash
end

# puts word_lengths('this is fun') #=> {'this'=>4, 'is'=>2, 'fun'=>3}
# puts word_lengths('When in doubt, leave it out') #=> {'When'=>4, 'in'=>2, 'doubt,'=>6, 'leave'=>5, 'it'=>2, 'out'=>3}

# -------
# Hash representation of As and Es count
def ae_count(str)
  count = Hash.new(0)
  str.each_char do | char |
    if char == 'e' || char == 'a'
      count[char] += 1
    end
  end
  return count
end

# puts ae_count('everyone can program') #=> {'a'=>2, 'e'=>3}
# puts ae_count('keyboard') #=> {'a'=>1, 'e'=>1}

# -------
# Hash representation of an array's elements
def element_count(arr)
  count = Hash.new(0)
  arr.each do | el |
    count[el] += 1
  end
  return count
end

# puts element_count(['a', 'b', 'a', 'a', 'b']) #=> {'a'=>3, 'b'=>2}
# puts element_count(['red', 'red', 'blue', 'green']) #=> {'red'=>2, 'blue'=>1, 'green'=>1}

# -------
# Discard non upcase keys of a hash
def select_upcase_keys(hash)
  upcase = Hash.new('')

  hash.each do | k, v |
    if k.upcase == k
      upcase[k] = v
    end
  end

  return upcase
end

# print select_upcase_keys({'make'=> 'Tesla', 'MODEL'=> 'S', 'Year'=> 2018, 'SEATS'=> 4}) # => {'MODEL'=>'S', 'SEATS'=>4}
# puts
# print select_upcase_keys({'DATE'=>'July 4th','holiday'=> 'Independence Day', 'type'=>'Federal'}) # => {'DATE'=>'July 4th'}
# puts

# -------
# Given a string representation of a poker hand,
# return total score from each card's value
def hand_score(hand)
  score = 0
  card_value = {
    'A' => 4,
    'K' => 3,
    'Q' => 2,
    'J' => 1,
  }
  hand.each_char { | char | score += card_value[char.upcase] }
  return score
end

# puts hand_score('AQAJ') #=> 11
# puts hand_score('jJka') #=> 9

# -------
# Return an array of the most frequent letters in a string
def frequent_letters(string)
  frequent = []
  letters_count = Hash.new(0)

  string.each_char { | char | letters_count[char] += 1 }
  letters_count.each do | k, v |
    if v > 2
      frequent << k
    end
  end

  return frequent
end

# print frequent_letters('mississippi') #=> ['i', 's']
# puts
# print frequent_letters('bootcamp') #=> []
# puts

# -------
# Transform a hash to an nested array of key/value arrays
def hash_to_pairs(hash)
  pairs = []
  hash.each { |k,v|  pairs << [k,v] }
  return pairs
end

# print hash_to_pairs({'name'=>'skateboard', 'wheels'=>4, 'weight'=>'7.5 lbs'}) #=> [['name', 'skateboard'], ['wheels', 4], ['weight', '7.5 lbs']]
# puts
# print hash_to_pairs({'kingdom'=>'animalia', 'genus'=>'canis', 'breed'=>'German Shepherd'}) #=> [['kingdom', 'animalia'], ['genus', 'canis'], ['breed', 'German Shepherd']]
# puts

# -------
# Hash keys being unique by design,
# use this feature to return all unique elements in an array
def unique_elements(arr)
  unique_hash = Hash.new(0)
  arr.each { |val| unique_hash[val] += 1 }
  return unique_hash.keys
end

# print unique_elements(['a', 'b', 'a', 'a', 'b', 'c']) #=> ['a', 'b', 'c']
# puts

# -------
# Given an array and a hash,
# replace the array elements matching a hash key
# with the corresponding value
def element_replace(arr, hash)
  hash.each do |k,v|
    if arr.index(k)
      arr[arr.index(k)] = v
    end
  end
  return arr
end

# arr1 = ['LeBron James', 'Lionel Messi', 'Serena Williams']
# hash1 = {'Serena Williams'=>'tennis', 'LeBron James'=>'basketball'}
# print element_replace(arr1, hash1) # => ['basketball', 'Lionel Messi', 'tennis']
# puts

# arr2 = ['dog', 'cat', 'mouse']
# hash2 = {'dog'=>'bork', 'cat'=>'meow', 'duck'=>'quack'}
# print element_replace(arr2, hash2) # => ['bork', 'meow', 'mouse']
# puts
