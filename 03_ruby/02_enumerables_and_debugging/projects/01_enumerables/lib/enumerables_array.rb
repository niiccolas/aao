class Array
  def my_each
    for el in self
      yield el
    end

    self
  end

  def my_select
    raise 'No block given' unless block_given?

    selects = []
    my_each { |el| selects << el if yield el }
    selects
  end

  def my_reject
    raise 'No block given' unless block_given?

    rejects = []
    my_each { |el| rejects << el unless yield el }
    rejects
  end

  def my_any?
    my_each { |el| return true if yield el }

    false
  end

  def my_all?
    my_each { |el| return false unless yield el }

    true
  end

  def my_flatten
    flattened = []

    my_each do |el|
      if el.is_a? Array
        flattened.concat(el.my_flatten)
      else
        flattened << el
      end
    end

    flattened
  end

  def my_zip(*args)
    length.times.with_object([]) do |i, zipped_array|
      zipped_element = [self[i]]

      args.each { |arg| zipped_element << arg[i] }

      zipped_array << zipped_element
    end
  end

  def my_rotate(rotations = 1)
    mid_array_idx = rotations % length

    drop(mid_array_idx) + take(mid_array_idx)
  end

  def my_join(separator = '')
    joined = ''

    my_each do |char|
      joined += char
      joined += separator unless char == self[-1]
    end

    joined
  end

  def my_reverse
    reversed = []

    my_each { |el| reversed.unshift el }

    reversed
  end
end
