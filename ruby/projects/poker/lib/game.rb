require_relative 'deck'
require_relative 'player'
require 'tty-table'
require 'tty-prompt'

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
    @tty            = TTY::Prompt.new
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

  def draw
    players.rotate.each do |player|
      next if player.status == 'folded'

      render_game(player)
      choices = [
        { name: 'Yes', value: true },
        { name: 'Stand pat', value: false }
      ]
      prompt = tty.select("\n\nChange cards #{player.name}?", choices, filter: true)

      unless prompt
        player.status = 'stands pat'
        next
      end

      choices = {}
      player.hand.draw.split(' ').each_with_index { |card, i| choices[card] = i }
      discards = tty.multi_select('Which ones?', choices, cycle: true)
      @muck += player.discard(discards) # add discards to the muck
      player.status = "discards #{discards.count}"

      discards.count.times do # distribe n discards new cards
        player.hand.add_card(deck.take_first_card)
        player.hand.sort_by_rank
      end
    end
  end

  def showdown
    render_game
    hand_values   = players.map { |player| player.hand.hand_value }
    kicker_values = players.map { |player| player.hand.kicker_value }
    tie           = hand_values.count(hand_values.max) > 1
    winner        = ''

    if tie
      hand_values.each_with_index do |value, i|
        kicker_values[i] = 0 unless value == hand_values.max
      end
      winner = kicker_values.index(kicker_values.max)
    else
      winner = hand_values.index(hand_values.max)
    end

    players.each { |player| player.status = player.hand.name }
    render_game

    print "\n\n  #{players[winner].name} wins with a #{players[winner].hand.name}"
    players[winner].wins(@game_pot)
    @game_pot = 0 # reset the game pot
    gets
  end

  def render_game(current_player = nil)
    system('clear')
    players_render = {}
    players.each_with_index do |player, i|
      name = if current_player
               if current_player.name == player.name
                 Pastel.new.decorate(player.name, :black, :on_green)
               else
                 player.name
               end
             else
               player.name
             end

      dealer = i.zero? ? '(dealer)' : ''
      players_render["player#{i}".to_sym] = "#{name} - $#{player.player_pot} #{dealer}\n#{player.hand.draw}\n#{player.status}"
    end

    pot   = { value: "\n$#{game_pot}", alignment: :center, padding: 5 }
    table = TTY::Table.new [ # Game is rendered within a 3x3 table
      ['', players_render[:player2], ''],
      [players_render[:player1], pot, players_render[:player3]],
      ['', players_render[:player0], '']
    ]

    puts table.render(
      border: { separator: :each_row },
      multiline: true,
      padding: [0, 2], # left-right, top-bottom
    )
  end
end
