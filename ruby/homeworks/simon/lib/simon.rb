class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over       = false
    @seq             = []
    @seq_player      = []
  end

  def play

  end

  def take_turn

  end

  def show_sequence

  end

  def require_sequence

  end

  def add_random_color

  end

  def round_success_message

  end

  def game_over_message
    puts "\nGame over 👎"
    puts "Simon said: #{seq.join(' > ')}"
    puts "You said:   #{seq_player.join(' > ')}"
  end

  def reset_game

  end
end
