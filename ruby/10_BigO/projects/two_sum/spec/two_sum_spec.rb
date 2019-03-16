require 'two_sum'
context 'Two Sum problem' do
  has_sum      = [[9, 3, 1, 7, 5], 10]
  has_sum2     = [[-29, 0, 1, 3.4, 2], 3]
  has_not_sum  = [[0, 1, 5, 7], 10]
  has_not_sum2 = [[-32, -10, 2, 88, 3, 41, 11], 888]

  describe '#bad_two_sum' do
    context 'when any two integers in the array amount to the target sum' do
      it 'returns true' do
        expect(bad_two_sum?(*has_sum)).to be true
        expect(bad_two_sum?(*has_sum2)).to be true
      end
    end

    context 'else' do
      it 'returns false' do
        expect(bad_two_sum?(*has_not_sum)).to be false
      end
    end

    context 'when passed an empty array' do
      it 'returns false' do
        expect(bad_two_sum?([], 22)).to eq(false)
      end
    end

    context 'when passed an array of length 1' do
      it 'returns false' do
        expect(okay_two_sum?([22], 22)).to eq(false)
      end
    end
  end

  describe '#okay_two_sum?' do
    context 'when any two integers in the array amount to the target sum' do
      it 'returns true' do
        expect(okay_two_sum?(*has_sum)).to be true
        expect(okay_two_sum?(*has_sum2)).to be true
      end
    end

    context 'else' do
      it 'returns false' do
        expect(okay_two_sum?(*has_not_sum)).to be false
        expect(okay_two_sum?(*has_not_sum2)).to be false
      end
    end

    context 'when passed an empty array' do
      it 'returns false' do
        expect(okay_two_sum?([], 22)).to eq(false)
      end
    end

    context 'when passed an array of length 1' do
      it 'returns false' do
        expect(okay_two_sum?([22], 22)).to eq(false)
      end
    end
  end
end
