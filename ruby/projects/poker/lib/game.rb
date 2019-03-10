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
      pay_ante
      deal_cards
      reset_statuses_and_raise
      betting_round until betting_over?
      if others_folded
        showdown
      else
        draw
        if all_stand_pat?
          showdown
        else
          reset_raises
          betting_round until betting_over?
          showdown
        end
      end
      recompose_deck
      switch_dealer
    end
  end

  def game_over?
    bankrupt_players = players.count { |player| player.bankrupt? }
    (players.count - bankrupt_players) == 1
  end

  def recompose_deck
    players.each(&:hand_to_deck)
    @deck = Deck.new
    @deck.shuffle!
  end

  def switch_dealer
    players.rotate!
    @dealer         = @players[0]
    @current_player = @players[1]
  end

  def deal_cards
    5.times do
      players.each do |player|
        next if player.bankrupt?
        player.hand.add_card(deck.take_first_card)
        player.hand.sort_by_rank
      end
    end
  end

  def reset_statuses_and_raise
    players.each { |player| player.status = ' ' }
    players.each { |player| player.unfold }
    reset_raises
  end

  def reset_raises
    @last_raise = 0
  end

  def others_folded
    n_folded_players = players.count { |player| player.folded? }
    n_folded_players == players.count - 1
  end

  def all_stand_pat?
    active_players.all? { |player| player.status == 'stands pat' }
  end

  def all_check?
    active_players.all? { |player| player.status == 'checks' }
  end

  def active_players
    active_players = players.reject { |player| player.folded? }
  end

  def all_call?
    num_calling = active_players.count do |player|
      player.status == "calls $#{last_raise}"
    end
    num_calling == active_players.count - 1
  end

  def betting_over?
    bets = ['bets', 'raises', 'ALL-IN!']
    one_bet = active_players.count { |player| player.status.start_with?(*bets) } == 1

    one_bet && all_call? || all_check? || all_stand_pat?
  end

  def betting_round
    players.rotate.each do |player|
      render_game(player)
      next if player.folded?
      next if player.bankrupt?
      break if betting_over?

      menu_options = last_raise.zero? ? %w[check bet fold] : %w[call raise fold]
      while (menu = tty.select("\n\n#{player.name}, what to do?", menu_options, filter: true, cycle: true))
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
      next if player.folded?
      next if player.bankrupt?

      render_game(player)
      choices = [
        { name: 'Yes', value: true },
        { name: 'Stand pat', value: false }
      ]
      prompt = tty.select("\n\nChange cards #{player.name}?", choices, filter: true, cycle: true)

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
    hand_values   = players.map do |player|
      player.folded? ? 0 : player.hand.hand_value
    end
    kicker_values = players.map do |player|
      player.folded? ? 0 : player.hand.kicker_value
    end
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
    players_info = {}
    players.each_with_index do |player, i|
      playerID = players.find { |player| player.id == i }
      name = if current_player
               if current_player.name == playerID.name
                 Pastel.new.decorate(playerID.name, :black, :on_green)
               else
                 playerID.name
               end
             else
               playerID.name
             end

      button = playerID.name == dealer.name ? '(DEALER)' : ''
      players_info["player#{i}".to_sym] = <<~PLAYER_INFO
      #{name}, $#{playerID.player_pot} #{button}
      #{playerID.hand.draw}
      #{playerID.status}
      PLAYER_INFO
      render_table(players_info)
    end
  end

  def render_table(players_info)
    system('clear')
    pot   = { value: "\n$#{game_pot}", alignment: :center, padding: 5 }
    table = TTY::Table.new [ # Game is rendered within a 3x3 TTY table
      ['', players_info[:player2], ''],
      [players_info[:player1], pot, players_info[:player3]],
      ['', players_info[:player0], '']
    ]
    puts table.render(
      border: { separator: :each_row }, multiline: true, padding: [0, 2]
    )
  end
end
