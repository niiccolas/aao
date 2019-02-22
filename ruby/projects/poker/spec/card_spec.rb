require 'card'

describe 'Card' do
  let(:values) { (2..14).to_a }
  suits       = %i[diamonds clubs hearts spades]
  faces       = %i[2 3 4 5 6 7 8 9 10 J Q K A]
  random_face = faces.sample
  subject { Card.new(suits.sample, random_face, 14) }

  it 'has a value' do
    expect(values).to include(subject.value)
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

  it 'can be revealed' do
    subject.reveal
    expect(subject.revealed?).to be true
  end
end
