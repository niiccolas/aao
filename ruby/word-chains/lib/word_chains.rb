if ARGV.length != 2
  puts 'Pass two comma-separated words as arguments'
  ARGV = %w[duck ruby]
end
unless ARGV.all? { |el| el.length == ARGV[0].length }
  puts 'Error! Arguments must be of same length'
end

# Given two words, builds a chain of words
# connecting the first to the second one, e.g.:
# ```
# ruby word_chains.rb duck ruby
# => duck
# => ruck
# => rusk
# => ruse
# => rube
# => ruby
# ```
class WordChainer
  attr_accessor :dictionary

  def initialize(dictionary_file_name = 'dictionary.txt')
    require 'set'
    @dictionary = [].to_set

    Dir.chdir(File.dirname(__FILE__))
    File.open(dictionary_file_name).each_line do |word|
      @dictionary.add(word.chomp) if word.chomp.length == ARGV[0].length
    end
  end

  # For a given word, go thru each index and at that index,
  # test every letter of the alphabet except the current one.
  # If the letter collage creates an existing word,
  # save it to the adjacent words array.
  def adjacent_words(adj_word)
    adjacent = []

    adj_word.each_char.with_index do |old_letter, i|
      ('a'..'z').each do |new_letter|
        next if new_letter == old_letter

        letter_collage    = adj_word.dup
        letter_collage[i] = new_letter
        adjacent << letter_collage if @dictionary.include?(letter_collage)
      end
    end
    adjacent
  end
end
