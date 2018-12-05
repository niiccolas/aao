class HumanPlayer
  attr_accessor :previous_guess

  def initalize
    @previous_guess = nil
  end

  def get_input
    prompt
    parse(STDIN.gets.chomp)
  end

  def prompt
    puts "To flip, enter the row immediately followed by the column (e.g.: '23')"
    print '> '
  end

  def parse(input_string)
    input_string.to_i.divmod(10)
    # input_string.split(',').map(&:to_i)
  end

  def receive_match(_pos1, _pos2)
    kudos = %w(✌️ 👌 👍)
    puts "It's a match! #{kudos[rand(3)]}"
    sleep(1)
  end

  def receive_revealed_card(pos, value); end
end