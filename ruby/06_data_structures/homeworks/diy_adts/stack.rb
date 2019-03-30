class Stack # Last In, Last Out
  def initialize
    @stack_array = []
  end

  def push(el)
    @stack_array.unshift(el)
  end

  def pop
    @stack_array.shift
  end

  def peek
    @stack_array.first
  end
end
