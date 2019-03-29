# No need to change or write any code in this file.
#
# After you complete all specs, you can simulate your game by
# running this file with `ruby lib/play_mastermind.rb` in your terminal!

require_relative "mastermind"
puts "Welcome to Mastermind"
puts "Ruby edition"
puts "* * *"
puts "Instructions: Valid pegs are R, G, B and Y."
puts "You must break the codemaker's code,"
puts "by guessing its pattern of colors and positions."
puts "* * *"
puts "Enter a size for the game: "
mastermind = Mastermind.new(gets.chomp.to_i)

until (mastermind.ask_user_for_guess) do
  puts "-------------------------"
end

puts "You win!"
