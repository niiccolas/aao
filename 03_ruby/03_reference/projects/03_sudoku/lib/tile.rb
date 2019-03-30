require 'paint'

class Tile
  attr_reader :value

  def initialize(value)
    @value = !(1..9).cover?(value) ? nil : value
    @clue  = (1..9).cover?(value) ? true : false
  end

  def value=(value)
    raise 'Cannot modify clues' if @clue

    @value = value
  end

  def to_s
    return Paint[@value.to_s, :green] if @clue
    return @value.to_s                if @value

    ' '
  end
end
