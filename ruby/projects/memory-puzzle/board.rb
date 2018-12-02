require_relative 'card'

class Board
  attr_accessor :grid

  def initialize(num_pairs)
    @grid = populate(num_pairs)
  end

  def populate(num_pairs)
    Card.shuffled_pairs(num_pairs)
  end

  def render
    @grid.each_with_index do |card, index|
      puts if (index % grid_length).zero? && index != 0
      print card.to_s + ' '
    end
  end

  def grid_length
    require 'cmath'
    CMath.sqrt(@grid.length).to_i
  end

  def won?
    @grid.all? { |el| el.revealed? }
  end

  def reveal(guessed_pos)
    @grid[guessed_pos].reveal unless @grid[guessed_pos].revealed?
  end
end
