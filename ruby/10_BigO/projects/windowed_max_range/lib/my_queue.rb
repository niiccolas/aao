class MyQueue
  def initialize
    @store = []
  end

  def enqueue(value)
    @store.unshift(value)
    nil
  end

  def dequeue
    @store.pop
  end

  def empty?
    @store.empty?
  end

  def size
    @store.size
  end

  def peek
    @store[-1]
  end
end
