# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    return nil if self.empty?

    self.max - self.min
  end

  def average
    return nil if self.empty?

    self.reduce(:+) / self.count.to_f
  end

  def median
    return nil if self.empty?

    sorted = self.sort
    length = sorted.length
    (sorted[(length - 1) / 2] + sorted[length / 2]) / 2.0
  end

  def counts
    count_hash = Hash.new(0)
    self.each { |el| count_hash[el] += 1 }
    count_hash
  end

  def my_count(value)
    value_count = 0
    self.each { |el| value_count += 1 if el == value }
    value_count
  end

  def my_index(value)
    self.each_with_index { |el, idx| return idx if el == value }
    nil
  end

  def my_uniq
    uniques = Hash.new(0)
    self.each { |el| uniques[el] += 1 }
    uniques.keys
  end

  def my_transpose
    transposed = []
    i          = 0
    j          = 0
    while i < self.length
      row = []
      while j < self.length
        row << self[j][i]
        j += 1
      end
      transposed << row
      j = 0
      i += 1
    end

    transposed
  end
end
