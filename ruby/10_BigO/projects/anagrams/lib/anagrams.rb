# O(n!) factorial time complexity
# At a length of 10 characters in str1,
# this function has to produce more than 3M permutations
def first_anagram?(str1, str2)
  all_anagrams = str1.chars.permutation.to_a.map(&:join).drop(1)

  all_anagrams.include?(str2)
end
