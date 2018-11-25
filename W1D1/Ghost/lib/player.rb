# :nodoc:
class Player
  attr_accessor :name, :type

  def initialize(name)
    @name = name
    @type = 'human'
  end

  def guess(*args)
    gets.chomp.downcase
  end

  def alert_invalid_guess(letter, fragment)
    puts
    puts "🚫 “#{letter}” is invalid input! Pick a letter of the alphabet,\n"
    print "while forming an existing word. Try again: "
  end
end
