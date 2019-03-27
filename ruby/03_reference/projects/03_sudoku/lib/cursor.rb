require 'io/console'

class Cursor
  KEYMAP = {
    '1' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'h' => :left,
    'j' => :down,
    'k' => :up,
    'l' => :right,
    'w' => :up,
    'a' => :left,
    's' => :down,
    'd' => :right,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "\177" => :backspace,
    "\004" => :delete,
    "\u0003" => :ctrl_c
  }.freeze

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }.freeze

  attr_reader :position, :board

  def initialize(board, position = [0, 0])
    @board      = board
    @position = position
    # @selected   = false
  end

  def keyboard_input
    handle_key(KEYMAP[read_char])
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    input
  end

  def handle_key(key)
    case key
    when :backspace, :delete
      return {pos: position, val: nil}
    when :ctrl_c
      Process.exit(0)
    when :left, :right, :up, :down
      update_pos(MOVES[key])
    when (1..9)
      { pos: position, val: key }
    end
  end

  def update_pos(diff)
    c_x, c_y = position
    d_x, d_y = diff

    new_pos   = [(c_x + d_x), (c_y + d_y)]
    @position = new_pos if @board.valid_pos?(new_pos)
  end
end
