require_relative 'my_stack'

class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  def empty?
    @store.empty?
  end

  def size
    @store.size
  end

  def push(value)
    @store.push(
      max: eval_max(value),
      min: eval_min(value),
      val: value
    )
  end

  def eval_max(value)
    @store.empty? ? value : [max, value].max
  end

  def eval_min(value)
    @store.empty? ? value : [min, value].min
  end

  def pop
    @store.pop[:val] unless empty?
  end

  def peek
    @store.peek[:val] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  def max
    @store.peek[:max] unless empty?
  end
end
