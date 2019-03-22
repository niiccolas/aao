require_relative 'my_stack'

class StackQueue
  def initialize
    @in_stack  = MyStack.new
    @out_stack = MyStack.new
  end

  # O(1)
  def enqueue(value)
    @in_stack.push(value)
    nil
  end

  # The stack is turned into a queue in O(n). This being the case only once every 2 dequeues, the time complexity is 0(1)
  def dequeue
    if @out_stack.empty?
      @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end

    @out_stack.pop
  end

  def size
    @in_stack.size + @out_stack.size
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end
end
