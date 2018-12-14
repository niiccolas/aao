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

  def adjacent_words(adj_word)
    adjacent = {}
    (0...adj_word.length).each do |index|
      adjacent = @dictionary.select do |dict_word|
        dict_word.include?(adj_word.delete(adj_word[index])) &&
        dict_word != adj_word
      end
    end

    adjacent.empty? ? 'no adjacent found' : adjacent
  end
end
