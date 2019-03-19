class MyStack
  def initialize
    @store = []
  end

  def push(value)
    @store << value
    nil
  end

  def pop
    @store.pop
  end

  def empty?
    @store.empty?
  end

  def size
    @store.size
  end

  def peek
    @store.last
  end
end
