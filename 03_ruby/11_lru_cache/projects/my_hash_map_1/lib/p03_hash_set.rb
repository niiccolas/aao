class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { [] }
    @count = 0
  end

  def insert(key)
    key_size = key.is_a?(Integer) ? key : key.size
    resize! if key_size + 1 > num_buckets

    unless include?(key)
      self[key.hash % num_buckets] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash % num_buckets].include? key
  end

  def remove(key)
    if include?(key)
      self[key.hash % num_buckets].delete key
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store.concat(Array.new(num_buckets) { [] })
  end
end
