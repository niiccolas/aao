# Sanitize user input
if ARGV.length != 2
  puts 'Pass two comma-separated words as arguments'; exit
elsif !ARGV.all? { |el| el.length == ARGV[0].length }
  puts 'Error! Arguments must be of same length'; exit
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
  # save it to the adjacent_words array.
  def adjacent_words(word)
    adjacent_words = []

    word.each_char.with_index do |old_letter, i|
      ('a'..'z').each do |new_letter|
        next if new_letter == old_letter

        letter_collage    = word.dup
        letter_collage[i] = new_letter
        adjacent_words << letter_collage if @dictionary.include?(letter_collage)
      end
    end
    adjacent_words
  end

  def run(source, target)
    @current_words  = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty?
      break if @all_seen_words.include?(target)

      explore_current_words
    end

    build_path(target)
  end

  def explore_current_words
    # fill up with new words 1 step away from word in @current_words
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)

        @all_seen_words[adjacent_word] = current_word
        new_current_words << adjacent_word
      end
    end

    @current_words = new_current_words
  end

  def build_path(target)
    path = []
    current_word = target

    until current_word.nil?
      path << current_word
      current_word = @all_seen_words[current_word]
    end

    path.reverse
  end
end

# Build and display chain of words out of CLI arguments
p WordChainer.new.run(ARGV[0], ARGV[1])