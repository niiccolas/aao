require_relative 'code'

# :nodoc:
class Mastermind
  def initialize(code_length)
    @secret_code = Code.random(code_length)
  end

  def print_matches(code_instance)
    puts "Exact matches: #{@secret_code.num_exact_matches(code_instance)}"
    puts "Near matches: #{@secret_code.num_near_matches(code_instance)}"
  end

  def ask_user_for_guess
    puts 'Enter a code'
    user_guess = Code.from_string(gets.chomp)
    print_matches(user_guess)
    @secret_code == user_guess
  end
end
