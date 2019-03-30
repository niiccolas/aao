require 'benchmark/ips'
require 'colorize'

class ComplexityBenchmark
  # O(n^2) quadratic time complexity
  # O(1) constant space complexity
  def self.my_min_quadratic(arr)
    arr.each do |num1|
      smallest = true
      arr.each do |num2|
        smallest = false if num1 > num2
      end

      return num1 if smallest
    end
  end

  # O(n) linear time complexity
  # O(1) constant space complexity
  def self.my_min_linear(arr)
    min_num = arr.first
    arr.each { |num| min_num = num if num < min_num }

    min_num
  end

  # O(n^3) cubic time complexity
  def self.largest_contiguous_subsum_cubic(arr)
    subsums = []

    arr.each_index do |i|
      arr.each_index do |j|
        subsums << arr[i..j].reduce(:+) unless arr[i..j].empty?
      end
    end

    subsums.max
  end

  # O(n) linear time complexity
  # O(1) constant space complexity
  # Using Kadane's algorithm https://en.wikipedia.org/wiki/Maximum_subarray_problem#Kadane's_algorithm
  def self.largest_contiguous_subsum_linear(arr)
    largest = arr.first
    current = arr.first

    arr[1..-1].each do |num|
      current = [(current + num), num].max
      largest = current if current > largest
    end

    largest
  end

  def self.test(sample_size)
    test_array = Array.new(sample_size) { rand(sample_size) }

    Benchmark.ips do |x|
      x.report('my_min n')   { my_min_linear(test_array) }
      x.report('my_min n^2') { my_min_quadratic(test_array) }
      x.compare!
    end

    Benchmark.ips do |x|
      x.report('subsum Kadane') { largest_contiguous_subsum_linear(test_array) }
      x.report('subsum naive') { largest_contiguous_subsum_cubic(test_array) }
      x.compare!
    end
  end

  def self.run
    system('clear')
    loop do
      sample_size = prompt_user
      test(sample_size)
    end
  end

  def self.prompt_user
    print "Enter test sample size, 'q' to quit: ".green
    user_input = gets.chomp
    exit if user_input == 'q'

    user_input.empty? ? 1 : user_input.to_i # defaults to 1
  end
end

ComplexityBenchmark.run
