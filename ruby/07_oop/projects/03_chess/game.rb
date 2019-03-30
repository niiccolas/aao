require_relative 'board'
require_relative 'display'
require_relative 'human_player'
require 'colorize'

class ChessGame
  attr_reader :board, :display, :players
  attr_accessor :current_player

  def initialize
    @display = Display.new(Board.new)
    @board   = display.board
    @players = { whites: HumanPlayer.new(:white, display),
                 blacks: HumanPlayer.new(:black, display) }
    @current_player = players[:whites]
  end

  def play
    until board.checkmate?(current_player.color)
      begin
        move_from, move_to = make_move
        display.board.move_piece(move_from, move_to, self.current_player.color)
        swap_turn!
      rescue StandardError => e
        puts "\n  " + " #{e.message.capitalize}. Retry ".black.on_red
        sleep(2)
      end
    end
    display.render
    notify_players
  end

  private

  def notify_players
    if current_player.color == :white
      print "\n  " + " White plays ".black.on_light_white
    else
      print "\n  " + " Black plays ".on_black
    end

    if board.checkmate?(current_player.color)
      print ' CHECKMATE! '.black.on_red
    elsif board.in_check?(:white) || board.in_check?(:black)
      print ' Check! '.black.on_magenta
    end
  end

  def make_move
    move = []
    until move.length == 2
      system('clear')
      display.render
      notify_players
      register_move = display.cursor.get_input
      move << register_move unless register_move.nil?
    end
    move
  end

  def swap_turn!
    self.current_player = current_player == players[:whites] ? players[:blacks] : players[:whites]
  end
end

ChessGame.new.play if $PROGRAM_NAME == __FILE__
