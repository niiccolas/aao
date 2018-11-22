class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def guess
    gets.chomp
  end

  def alert_invalid_guess
    print "invalid input, try again: #{@fragment}"
  end
end
