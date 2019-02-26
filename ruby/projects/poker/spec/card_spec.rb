require 'card'

describe 'Card' do
  ranks       = (2..14).to_a
  suits       = %i[diamonds clubs hearts spades]
  faces       = %i[2 3 4 5 6 7 8 9 10 J Q K A]
  random_face = faces.sample
  subject { Card.new(suits.sample, random_face) }

  it 'has a rank' do
    expect(ranks).to include(subject.rank)
  end

  it 'has a suit' do
    expect(suits).to include(subject.suit)
  end

  it 'has a face' do
    expect(faces).to include(subject.face)
  end

  it 'is dealt face down' do
    expect(subject.revealed?).to be false
  end

  describe '#revealed?' do
    it 'returns false on a new card' do
      expect(subject.revealed?).to be false
    end
    context 'when card has been revealed' do
      it 'returns true' do
        subject.reveal!
        expect(subject.revealed?).to be true
      end
    end
  end

  describe '#reveal!' do
    it 'sets @revealed to true' do
      subject.reveal!
      expect(subject.revealed?).to be true
    end
  end
end
