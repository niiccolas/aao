class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    store[i]
  end

  def []=(i, val)
    validate!(i)
    store[i] = val
  end

  def length
    store.length
  end

  private

  def validate!(i)
    raise 'Overflow error' unless i.between?(0, store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count, :insertions

  def initialize(capacity = 8)
    @store     = StaticArray.new(capacity)
    @count     = 0
    @start_idx = 0
  end

  def [](i)
    return nil if i >= @count

    if i.negative?
      return nil if i < -@count
      return self[@count + i]
    end

    @store[(@start_idx + i) % capacity]
  end

  def []=(i, val)
    if i >= @count
      (i - @count).times { push(nil) } # when over-indexing
    elsif i.negative?
      return nil if i < -@count
      return self[@count + i] = val
    end

    if i == @count
      resize! if capacity == @count
      @count += 1
    end

    @store[(@start_idx + i) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    any? { |el| el == val }
  end

  def push(val)
    resize! if capacity == @count
    @store[(@start_idx + @count) % capacity] = val
    @count += 1
    self
  end

  def unshift(val)
    resize! if capacity == @count
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx] = val
    @count += 1
    self
  end

  def pop
    return nil if count.zero?

    last_element = @store[(@start_idx + @count - 1) % capacity]
    @count -= 1
    last_element
  end

  def shift
    return nil if @count.zero?

    @count -= 1
    first_element = @store[@start_idx]
    @start_idx    = (@start_idx + 1) % capacity
    first_element
  end

  def first
    return nil if @count.zero?

    @store[@start_idx]
  end

  def last
    return nil if @count.zero?

    @store[(@start_idx + @count - 1) % capacity]
  end

  def each
    return nil unless block_given?

    @count.times { |i| yield self[i] }
    self
  end

  def to_s
    '[' + inject([]) { |acc, el| acc << el }.join(', ') + ']'
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless length == other.length

    capacity.times { |i| return false unless @store[i] == other[i] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    each_with_index { |el, i| new_store[i] = el }

    @store     = new_store
    @start_idx = 0
  end
end
