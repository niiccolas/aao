require 'two_sum'
context 'Two Sum problem' do
  has_sum     = [[0, 1, 5, 7], 6]
  has_not_sum = [[0, 1, 5, 7], 10]

  describe '#bad_two_sum' do
    context 'when any two integers in the array amount to the target sum' do
      it 'returns true' do
        expect(bad_two_sum(*has_sum)).to be true
      end
    end
    context 'else' do
      it 'returns false' do
        expect(bad_two_sum(*has_not_sum)).to be false
      end
    end
  end
end
