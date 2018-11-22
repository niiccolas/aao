class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def guess
    gets.chomp.downcase
  end

  def alert_invalid_guess
    print "invalid input, try again: #{Game.fragment}"
  end
end
