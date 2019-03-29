class Queue
  def initialize
    @line = []
  end

  def add(el)
    @line << el
    nil
  end

  def remove
    @line.shift
  end
end

grocery_checkout = Queue.new

grocery_checkout.add("julie")
grocery_checkout.add("helene")
grocery_checkout.remove
grocery_checkout.add("zippy")
grocery_checkout.add("toona")
grocery_checkout.remove
grocery_checkout.remove
grocery_checkout.remove
