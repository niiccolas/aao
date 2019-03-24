require 'colorize'

class Tile
  attr_reader :value

  def initialize(value)
    @value = !(1..9).cover?(value) ? nil : value
    @given = (1..9).cover?(value) ? true : false
  end

  def value=(value)
    raise 'Cannot modify given tile' if @given

    @value = value
  end

  def to_s
    return @value.to_s.green if @given
    return @value.to_s       if @value

    ' '
  end
end
