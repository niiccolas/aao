require 'execution_time_difference'

context 'Given an array of integers' do
  arr1  = [0, 3, 5, 4, -5, 10, 1, 90]
  arr2  = [22, 1, 4, 9, -99]

  describe '#my_min_quadratic' do
    it 'returns the smallest element' do
      expect(my_min_quadratic(arr1)).to eq(-5)
      expect(my_min_quadratic(arr2)).to eq(-99)
      expect(my_min_quadratic(arr1)).not_to eq(90)
      expect(my_min_quadratic(arr2)).not_to eq(22)
    end
  end

  describe '#my_min_linear' do
    it 'returns the smallest element' do
      expect(my_min_linear(arr1)).to eq(-5)
      expect(my_min_linear(arr2)).to eq(-99)
    end
  end

  list1 = [5, 3, -7]
  list2 = [-13, -3, -25, -20, -3, -16, -23, -12, -5, -22, -15, -4, -7]
  list3 = [-2, 1, -3, 4, -1, 2, 1, -5, 4] # 6

  describe '#largest_contiguous_subsum_quadratic' do
    it 'returns the maximum sub-array sum' do
      expect(largest_contiguous_subsum_quadratic(list1)).to eq(8)
      expect(largest_contiguous_subsum_quadratic(list2)).to eq(-3)
      expect(largest_contiguous_subsum_quadratic(list3)).to eq(6)
    end
    it 'returns the same result as the linear implementation' do
      expect(largest_contiguous_subsum_quadratic(list1)).to eq(largest_contiguous_subsum_linear(list1))
    end
  end

  describe '#largest_contiguous_subsum_linear' do
    it 'returns the maximum sub-array sum' do
      expect(largest_contiguous_subsum_linear(list1)).to eq(8)
      expect(largest_contiguous_subsum_linear(list2)).to eq(-3)
      expect(largest_contiguous_subsum_linear(list3)).to eq(6)
    end

    it 'returns the same result as the quadratic implementation' do
      expect(largest_contiguous_subsum_linear(list1)).to eq(largest_contiguous_subsum_quadratic(list1))
    end
  end
end
