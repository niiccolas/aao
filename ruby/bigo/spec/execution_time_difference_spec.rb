require 'execution_time_difference'

describe '#my_min_quadratic' do
  arr1 = [0, 3, 5, 4, -5, 10, 1, 90]
  arr2 = [22, 1, 4, 9, -99]
  it 'returns the smallest element of an array' do
    expect(my_min_quadratic(arr1)).to eq(-5)
    expect(my_min_quadratic(arr2)).to eq(-99)
    expect(my_min_quadratic(arr1)).not_to eq(90)
    expect(my_min_quadratic(arr2)).not_to eq(22)
  end
end
