require_relative 'deck'
require_relative 'player'
require 'tty-table'
require 'tty-prompt'

class Game
  attr_reader :deck, :players, :ante, :dealer, :tty
  attr_accessor :game_pot, :last_raise

  def initialize
    register_players(4)
    @players_info   = {}
    @deck           = Deck.new
    @muck           = [] # Cards discarded in-game
    @ante           = 1
    @game_pot       = 0
    @last_raise     = 0
    @dealer         = @players[0]
    @current_player = @players[1]
    @tty            = TTY::Prompt.new
  end

  def register_players(n_players)
    @players = []
    names = %w[South West North East]
    n_players.times do |player_id|
      @players << Player.new(player_id, names[player_id])
    end
  end

  def pay_ante
    players.each do |player|
      render_game
      player.pay(ante)
      @game_pot += ante
    end
  end

  def play
    until game_over?
      reset_statuses_and_raise
      deal_cards
      pay_ante
      deal_cards
      betting_round until betting_over?
      draw
      if all_stand_pat?
        showdown
      else
        reset_statuses_and_raise
        betting_round until betting_over?
        showdown
      end
      recompose_deck
      switch_dealer
    end
  end

  def game_over?
    bankrupt_players = 0
    players.each do |player|
      bankrupt_players += 1 if player.bankrupt?
    end
    (players.count - bankrupt_players) == 1
  end

  def recompose_deck
    players.each(&:hand_to_deck)
    @deck = Deck.new
    @deck.shuffle!
  end

  def switch_dealer
    @dealer         = @players[0]
    @current_player = @players[1]
  end

  def deal_cards
    5.times do
      players.each do |player|
        player.hand.add_card(deck.take_first_card)
        player.hand.sort_by_rank
      end
    end
  end

  def reset_statuses_and_raise
    players.each { |player| player.status = ' ' }
    @last_raise = 0
  end

  def all_bets_called?
    statuses = ['bets', 'calls', 'folded', 'raises', 'ALL-IN']
    counter  = 0
    players.each { |player| counter += 1 if player.status.start_with?(*statuses) }
    all_checks    = players.all? { |player| player.status == 'checks' }
    all_stand_pat = players.all? { |player| player.status == 'stands pat' }

    counter == players.count || all_checks || all_stand_pat
  end

  def betting_round
    players.rotate.each do |player|
      render_game(player)
      next if player.status == 'folded'
      break if all_bets_called?

      menu_options = last_raise.zero? ? %w[check bet fold] : %w[call raise fold]
      while (menu = tty.select("\n\n#{player.name}, what to do?", menu_options, filter: true))
        if menu == 'fold'
          player.fold
          break
        elsif menu == 'call' && last_raise > 0
          player.call_bet(last_raise)
          @game_pot += last_raise
          break
        elsif menu == 'raise' && last_raise > 0
          @last_raise = bet = player.bet(last_raise)
          @game_pot += bet
          break
        elsif menu == 'check' && last_raise.zero?
          player.check
          break
        elsif menu == 'bet' && last_raise.zero?
          @last_raise = bet = player.bet
          @game_pot += bet
          break
        end
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
