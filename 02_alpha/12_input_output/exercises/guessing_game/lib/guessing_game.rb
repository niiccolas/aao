# :nodoc:
class GuessingGame
  def initialize(min, max)
    @min          = min
    @max          = max
    @num_attempts = 0
    @secret_num   = rand(min..max)
    @game_over    = false
  end

  # Read / Write
  attr_accessor :min
  attr_accessor :max
  attr_accessor :num_attempts

  # Read Only
  attr_reader :secret_num
  def game_over?
    @game_over
  end

  # Instance Methods
  def check_num(number)
    @num_attempts += 1

    if number > @secret_num
      puts 'too big'
    elsif number < @secret_num
      puts 'too small'
    else
      @game_over = true
      puts 'you win'
    end
  end

  def ask_user
    puts 'enter a number'
    user_guess = gets.chomp.to_i
    check_num(user_guess)
  end
end
