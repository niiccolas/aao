require 'player'

ghost_player = Player.new("ignatius")

describe "Player class" do
  describe "#initialize" do
    it "should take a name as string" do
      expect(ghost_player.name.is_a? String).to eq(true)
    end
  end
end