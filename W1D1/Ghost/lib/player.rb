# :nodoc:
class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess
    gets.chomp.downcase
  end

  def alert_invalid_guess(letter)
    puts "#{letter} is invalid input! Pick a letter of the alphabet,\n"
    print "while forming an existing word. Try again: "
  end
end
