require 'byebug'

# EASY

# Define a method that returns the sum of all the elements in its argument (an
# array of numbers).
def array_sum(arr)
  arr.reduce(0, :+)
end

# Define a method that returns a boolean indicating whether substring is a
# substring of each string in the long_strings array.
# Hint: you may want a sub_tring? helper method
def in_all_strings?(long_strings, substring)
  long_strings.all? { |long_string| sub_string?(long_string, substring) }
end

def sub_string?(string, substr)
  string.split(' ').any? { |str| str.include? substr }
end

# Define a method that accepts a string of lower case words (no punctuation) and
# returns an array of letters that occur more than once, sorted alphabetically.
def non_unique_letters(string)
  string.delete!(' ').chars.select { |e| string.count(e) > 1 }.uniq.sort
end

# Define a method that returns an array of the longest two words (in order) in
# the method's argument. Ignore punctuation!
def longest_two_words(string)
  string.gsub(/[[:punct:]]/, '').split.sort_by(&:length)[-2..-1]
end

# MEDIUM

# Define a method that takes a string of lower-case letters and returns an array
# of all the letters that do not occur in the method's argument.
def missing_letters(string)
  ('a'..'z').reject { |letter| string.downcase.include? letter }
end

# Define a method that accepts two years and returns an array of the years
# within that range (inclusive) that have no repeated digits. Hint: helper
# method?
def no_repeat_years(first_yr, last_yr)
  (first_yr..last_yr).select { |e| not_repeat_year?(e) }
end

def not_repeat_year?(year)
  year.to_s.chars.uniq == year.to_s.chars
end

# HARD

# Define a method that, given an array of songs at the top of the charts,
# returns the songs that only stayed on the chart for a week at a time. Each
# element corresponds to a song at the top of the charts for one particular
# week. Songs CAN reappear on the chart, but if they don't appear in consecutive
# weeks, they're "one-week wonders." Suggested strategy: find the songs that
# appear multiple times in a row and remove them. You may wish to write a helper
# method no_repeats?
def one_week_wonders(songs)
  songs.select { |song| no_repeats?(song, songs) }.uniq
end

def no_repeats?(song_name, songs)
  repeats = songs.select.with_index { |_el, idx| songs[idx] == songs[idx + 1] }
  repeats.none? { |song| song == song_name }
end

# print one_week_wonders(%w(la di da la la di do da di di))

# Define a method that, given a string of words, returns the word that has the
# letter "c" closest to the end of it. If there's a tie, return the earlier
# word. Ignore punctuation. If there's no "c", return an empty string. You may
# wish to write the helper methods c_distance and remove_punctuation.

def for_cs_sake(string)
  return '' unless string.include? 'c'

  remove_punctuation(string)
  c_words = string.split.select { |word| word.downcase.include? 'c' }
  c_words.min_by { |word| c_distance(word) }
end

def c_distance(word)
  (word.length - 1) - word.chars.rindex('c') # https://devdocs.io/ruby~2.5/array#method-i-rindex
end

def remove_punctuation(word)
  word.gsub!(/[[:punct:]]/, '') # https://devdocs.io/ruby~2.5/string#method-i-gsub-21
end

# Define a method that, given an array of numbers, returns a nested array of
# two-element arrays that each contain the start and end indices of whenever a
# number appears multiple times in a row. repeated_number_ranges([1, 1, 2]) =>
# [[0, 1]] repeated_number_ranges([1, 2, 3, 3, 4, 4, 4]) => [[2, 3], [4, 6]]

def repeated_number_ranges(arr)
  repeated_number_ranges = []
  index_start_end = []

  arr.each_with_index do |el, idx|
    if el == arr[idx + 1] && el != arr[idx - 1]
      # if == NEXT but != PREVIOUS
      index_start_end << idx
    elsif el == arr[idx - 1] && el != arr[idx + 1]
      # if  == PREVIOUS but != NEXT
      index_start_end << idx
      repeated_number_ranges << index_start_end unless index_start_end.empty?
      index_start_end = [] # reinitialize temp variable as empty array
    end
  end

  repeated_number_ranges
end
