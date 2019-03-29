# instance_vs_class_methods_part2.rb

# Agenda 
# - instance variables (attributes), every instance of class will have the same value for instance variable, because you are creating a class constant
# - class variables, single variable shared among all instances of your class

def yell_name
  "outside of class"
end

class Dog 
  def initialize(name)
    @name = name
  end

  # bark is a class method
  def self.bark
    "WOOOF!!!!!"
  end

  def self.compare_dogs(dog_1, dog_2)
    if (dog_1.name.length > dog_2.name.length)
      return dog_1.name
    else
      return dog_2.name
    end
  end

  # yell_name is an instance method
  def yell_name
    @name.upcase + "!"
  end

  # greet is an instance method
  def greet
    self.yell_name + " says hi."  # self specifies method within the class
  end

  def name
    @name
  end
end


# dog_1 = Dog.new("Millie")
# puts dog_1.yell_name

# puts dog_1.greet

# dog_2 = Dog.new("Spot")
# puts dog_2.bark

# p Dog.bark

d1 = Dog.new("Snoopy")
d2 = Dog.new("Spot")

puts Dog.compare_dogs(d1, d2)