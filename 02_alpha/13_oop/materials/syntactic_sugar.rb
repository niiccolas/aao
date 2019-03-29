class Queue
  def initialize
    @line = []
  end

  # def el_at_position(position)
  #   @line[position]
  # end

  def []=(position, el)
    @line[position] = el
  end

  def add(el)
    @line << el
    nil
  end

  def remove
    @line.shift
  end
end

checkout = Queue.new
checkout.add("julie")
checkout.add("helene")
# p checkout.el_at_position(0)
# p checkout.el_at_position(1)
# p checkout[1]
# p checkout[0]
# p checkout.[]=(0,"Helene")
p checkout[0] = "Helene"

p checkout

class Person
  attr_reader :first_name, :last_name, :age

  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def ==(other_person)
    self.last_name == other_person.last_name
  end

  def >(other_person)
    self.age > other_person.age
  end

end

person_1 = Person.new("Jane", "Doe", 42)
person_2 = Person.new("Lizzy", "Lollis", 3)

# person_1.>(person_2)
p person_1 > person_2

