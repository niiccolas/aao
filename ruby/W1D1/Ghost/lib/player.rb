# :nodoc:
class Player
  attr_accessor :name, :type

  def initialize(name)
    @name = name
    @type = 'human'
  end

  def guess(*_args)
    gets.chomp.downcase
  end

  def alert_invalid_guess(letter)
    print GhostUi.message_to_color("“#{letter}” is invalid input! Try again: ", :red)
  end
end
