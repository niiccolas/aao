# :nodoc:
class Hangman
  DICTIONARY = %w[cat dog bootcamp pizza]

  # Hangman:: class method
  def self.random_word
    DICTIONARY.sample
  end

  # Initialize
  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  # Accessors
  attr_accessor :guess_word
  attr_accessor :attempted_chars
  attr_accessor :secret_word
  attr_accessor :remaining_incorrect_guesses

  # Hangman# instance methods
  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    return [] unless @secret_word.include?(char)

    (0...@secret_word.length).find_all { |idx| @secret_word[idx, 1] == char }
  end

  def fill_indices(char, arr)
    arr.each { |idx| @guess_word[idx] = char }
  end
end
