require_relative 'piece'
require 'singleton'

class NullPiece < Piece
  attr_reader :symbol
  # Singleton forces NullPiece to always initialize as the same object
  include Singleton

  def initialize
    @symbol = ' '
    @color  = :none
  end

  def empty?
    true
  end

  def moves
    []
  end
end
