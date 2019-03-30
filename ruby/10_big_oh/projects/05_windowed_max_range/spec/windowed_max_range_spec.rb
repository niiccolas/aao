require 'windowed_max_range'

context 'Given an array, and a window size' do
  describe '#windowed_max_range' do
    it 'returns the maximum range' do
      expect(windowed_max_range([1, 0, 2, 5, 4, 8], 2)).to eq(4)
      expect(windowed_max_range([1, 0, 2, 5, 4, 8], 3)).to eq(5)
      expect(windowed_max_range([1, 0, 2, 5, 4, 8], 4)).to eq(6)
      expect(windowed_max_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
    end

    it 'returns an Integer' do
      expect(windowed_max_range([1, 0, 2, 5, 4, 8], 2)).to be_an_instance_of(Integer)
      expect(windowed_max_range([1, 0, 2, 5, 4, 8], 3)).to be_an_instance_of(Integer)
    end
  end

  describe '#better_windowed_max_range' do
    it 'returns the maximum range' do
      expect(better_windowed_max_range([1, 0, 2, 5, 4, 8], 2)).to eq(4)
      expect(better_windowed_max_range([1, 2, 3, 5], 3)).to eq(3)
      expect(better_windowed_max_range([1, 0, 2, 5, 4, 8], 3)).to eq(5)
      expect(better_windowed_max_range([1, 0, 2, 5, 4, 8], 4)).to eq(6)
      expect(better_windowed_max_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
    end

    it 'returns an Integer' do
      expect(better_windowed_max_range([1, 0, 2, 5, 4, 8], 2)).to be_an_instance_of(Integer)
      expect(better_windowed_max_range([1, 0, 2, 5, 4, 8], 3)).to be_an_instance_of(Integer)
    end
  end
end