class Simon
  COLORS = %w(red blue green yellow).freeze

  attr_accessor :sequence_length, :game_over, :seq, :seq_player

  def initialize
    @sequence_length = 1
    @game_over       = false
    @seq             = []
    @seq_player      = []
  end

  def play
    system('clear')
    take_turn until game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    unless game_over
      self.sequence_length += 1
      round_success_message
    end
  end

  def show_sequence
    add_random_color
    system('clear')

    seq.each do |color|
      puts "Memorize the color sequence (Round #{@sequence_length}):"
      sleep(0.4)
      print color
      ticking_dots(3)
      system('clear')
    end
  end

  def require_sequence
    puts "Enter the color sequence (Round #{@sequence_length}): "
    self.seq_player = gets.chomp.downcase.split(' ')

    self.game_over = true if seq_player != seq
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "\nCorrect 👍"
    sleep(1.5)
  end

  def game_over_message
    puts "\nGame over 👎"
    puts "Simon said: #{seq.join(' > ')}"
    puts "You said:   #{seq_player.join(' > ')}"
  end

  def reset_game
    self.sequence_length = 1
    self.game_over = false
    self.seq = []
    self.seq_player = []
  end

  def ticking_dots(num)
    num.times { print '.'; sleep(0.5) }
  end
end

simon = Simon.new
p simon.play
