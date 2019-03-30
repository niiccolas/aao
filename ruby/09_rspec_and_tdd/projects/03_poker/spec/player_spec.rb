require 'player'

describe 'Player' do
  player_name = 'Daniel Negreanu'
  subject { Player.new(player_name) }

  it 'has a hand' do
    subject.hand.draw_hand
    expect(subject.hand).to be_an_instance_of Hand
  end

  it 'has a name' do
    expect(subject.name).to be_an_instance_of String
    expect(subject.name).to eq(player_name)
  end

  it 'has a pot' do
    expect(subject.pot).to be_an_instance_of Integer
    expect(subject.pot).to eq(35)
  end

  describe '#prompt_bet' do
    it 'checks user input'
  end

  describe 'capture_name' do
    it 'returns foo as input' do
      allow($stdin).to receive(:gets).and_return('foo')
      name = $stdin.gets

      expect(name).to eq('foo')
    end
  end
end