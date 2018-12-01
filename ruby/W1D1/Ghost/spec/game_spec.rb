require 'game'

describe "Game class" do
  players = [Player.new('Slimer'), Player.new('Casper')]
  ghost_game = Game.new(players)

  describe "#initialize" do
    it "should set @dictionary to a hash with keys being words of the dictionary" do
      expect(ghost_game.dictionary.keys).to_not include(nil)
    end
    it "should set @players to an array" do
      expect(ghost_game.players.is_a? Array).to eq(true)
    end
    it "should set @fragment to a string" do
      expect(ghost_game.fragment.is_a? String).to eq(true)
    end

    invalid_players = Game.new([Player.new(123), Player.new(true)])
    it "should only accept string for player names" do
      expect(ghost_game.players.all? { |player| player.name.is_a? String }).to eq(true)

      expect(invalid_players.players.all? { |player| player.name.is_a? String }).to eq(false)
    end
  end

  describe "#current_player" do
    it "should return the first element of the @players array" do
      expect(ghost_game.current_player).to eq(ghost_game.players.first)
    end
  end

  describe "#previous_player" do
    it "should return the last element of the @players array" do
      expect(ghost_game.previous_player).to eq(ghost_game.players.last)
    end
  end

  describe "#next_player!" do
    it "should modify the @players array" do
      untouched_players_array = ghost_game.players.clone
      ghost_game.next_player!
      expect(ghost_game.players).to_not eq(untouched_players_array)
    end
  end
end