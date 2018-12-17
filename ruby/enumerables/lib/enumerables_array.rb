# :nodoc:
class Array
  def my_each(&block)
    self.length.times do |i|
      block.call(self[i])
    end

    self
  end

  def my_select(&block)
    raise 'ERROR: No block given' unless block_given?

    selects = []
    self.my_each do |element|
      selects << element if block.call(element)
    end
    selects
  end

  def my_reject(&block)
    raise 'ERROR: No block given' unless block_given?

    rejects = []
    self.my_each do |element|
      rejects << element unless block.call(element)
    end
    rejects
  end

  def my_any?(&block)
    raise 'ERROR: No block given' unless block_given?

    self.my_each do |element|
      return true if block.call(element)
    end
    false
  end

  def my_all?(&block)
    raise 'ERROR: No block given' unless block_given?
    self.my_each do |element|
      return false unless block.call(element)
    end
    true
  end

  def my_flatten(flattened = [])
    self.my_each do |element|
      if element.is_a? Array
        element.my_flatten(flattened)
      else
        flattened << element
      end
    end
    flattened
  end

  def my_zip(*args)
    zipped = []

    self.length.times do |index|
      zipped_element = [self[index]]

      args.my_each do |arg|
        zipped_element << arg[index]
      end

      zipped << zipped_element
    end

    zipped
  end

  def my_rotate(rotations = 1)
    middle = rotations % self.length
    self.drop(middle) + self.take(middle)
  end

  def my_join(separator = '')
    joined = ''

    self.my_each { |element| joined += element + separator }

    joined
  end

  def my_reverse
    reversed = []

    self.my_each { |element| reversed.unshift(element) }

    reversed
  end
end
