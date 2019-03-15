# O(n^2) quadratic time complexity
# O(n) linear space complexity
def bad_two_sum(arr, target_sum)
  arr.each_with_index do |num1, i|
    arr[i..-1].each do |num2|
      next if num1 == num2

      return true if (num1 + num2) == target_sum
    end
  end

  false
end
