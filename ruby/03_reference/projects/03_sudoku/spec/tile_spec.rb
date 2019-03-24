require 'tile'

describe 'Tile' do
  let(:value_given) { Tile.new(9) }
  let(:no_value_given) { Tile.new(0) }

  context 'when given a value' do
    it '@value is an Integer between 1-9' do
      expect(value_given.value).to be_an_instance_of(Integer)
      expect(1..9).to include(value_given.value)
    end

    it '@given is true' do
      expect(value_given.instance_variable_get(:@given)).to be(true)
    end

    describe '#value=' do
      it 'cannot change @value' do
        expect { value_given.value = 9 }.to raise_error('Cannot modify given tile')
      end
    end

    describe '#to_s' do
      it 'returns @value as green string' do
        num          = rand(1..9)
        color_output = Tile.new(num)

        expect(color_output.to_s).to eq("\e[0;32;49m#{num}\e[0m")
      end
    end
  end

  context 'when given no value' do
    it '@value is 0' do
      expect(no_value_given.value).to be(nil)
    end

    it '@given is false' do
      expect(no_value_given.instance_variable_get(:@given)).to be(false)
    end

    describe '#value=' do
      it 'can change @value' do
        no_value_given.value = 9

        expect(no_value_given.value).to eq(9)
      end
    end

    describe '#to_s' do
      it "returns ' '" do
        expect(no_value_given.to_s).to eq(' ')
      end
    end
  end
end
