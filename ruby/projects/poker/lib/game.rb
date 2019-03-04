require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :deck, :players, :ante, :dealer

  attr_accessor :game_pot, :last_raise

  def initialize
    @players = [
      Player.new('Player01'),
      Player.new('Player02'),
      Player.new('Player03'),
      Player.new('Player04')
    ]
    @deck           = Deck.new
    @muck           = [] # discarded cards in poker parlance
    @ante           = 1
    @game_pot       = 0
    @last_raise     = 0
    @dealer         = @players[0]
    @current_player = @players[1]
  end

  def play
    deal_cards
    pay_ante

    players.rotate!
    betting_round
    # discard
    # showdown #! pot is split if players have equally ranked hands
  end

  def pay_ante
    players.each { |player| player.pay(ante) }
    @game_pot += players.count * ante
  end

  def deal_cards
    5.times do
      players.each do |player|
        player.hand.add_card(deck.take_first_card)
      end
    end
  end

  def betting_round
    players.each do |player|
      render_game
      puts "\n\n#{player.name}"
      puts '-' * 35

      prompt = last_raise.zero? ? 'c(h)eck, (b)et,' : '(c)all, (r)aise,'
      print prompt + ' (f)old? '
      # print "#{prompt} (f)old? "

      while (user_input = gets.chomp.upcase.to_sym)
        if user_input == :F
          player.fold
          break
        elsif user_input == :C && last_raise > 0
          player.call_bet(last_raise)
          @game_pot += last_raise
          break
        elsif user_input == :R && last_raise > 0
          @last_raise = bet = player.bet(last_raise)
          @game_pot += bet
          break
        elsif user_input == :H && last_raise.zero?
          player.check
          break
        elsif user_input == :B && last_raise.zero?
          @last_raise = bet = player.bet
          @game_pot += bet
          break
        end
        print 'Input error! Retry '
      end
    end
  end

  def discard
  end

  def showdown
  end

  def render_game
    system('clear')

    players.each_with_index do |player|
      dealer_tag = player == dealer ? '- DEALER' : ''
      puts "#{player.name} - #{player.player_pot} #{dealer_tag}"
      puts "#{player.status.capitalize}"
    end

    puts "Game pot: 💰#{game_pot}"
  end
end
