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

  def try_guess(char)
    if already_attempted?(char)
      puts 'that has already been attempted'
      false
    else
      @remaining_incorrect_guesses -= 1 unless @secret_word.include?(char)

      @attempted_chars << char
      fill_indices(char, get_matching_indices(char))
      true
    end
  end

  def ask_user_for_guess
    puts 'Enter a char:'
    try_guess(gets.chomp)
  end

  def win?
    if @guess_word.join == @secret_word
      print 'WIN'
      true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses.zero?
      puts 'LOSE'
      true
    else
      false
    end
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      true
    else
      false
    end
  end
end
