# O(n * n!) factorial time complexity
# O(n!) factorial space complexity
# At a length of 10 characters in string1,
# this method has to produce more than 3M permutations
def first_anagram?(string1, string2)
  all_anagrams = string1.chars.permutation.to_a.map(&:join).drop(1)

  all_anagrams.include?(string2)
end

# O(n^2) quadratic time complexity
# O(n) linear space complexity
def second_anagram?(string1, string2)
  string2 = string2.chars

  string1.each_char do |char|
    char_index = string2.find_index(char)
    string2.delete_at(char_index) if char_index
  end

  string2.empty?
end

# O(n log n) log-linear time complexity
# O(n) linear space complexity
def third_anagram?(string1, string2)
  string1.chars.sort == string2.chars.sort
end

# 0(n) linear time complexity
# O(1) constant space complexity since keys are the (constant) letters of the alphabet
def fourth_anagram?(string1, string2)
  letter_counts = Hash.new(0)

  (string1 + string2).each_char do |letter|
    letter_counts[letter] += 1
  end

  letter_counts.values.uniq.length == 1
end
