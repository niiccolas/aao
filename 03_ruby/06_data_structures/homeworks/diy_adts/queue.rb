class Queue # First In, First Out
  def initialize
    @queue_array = []
  end

  def enqueue(el)
    @queue_array.unshift(el)
    el
  end

  def dequeue
    @queue_array.pop
  end

  def peek
    @queue_array.last
  end
end
