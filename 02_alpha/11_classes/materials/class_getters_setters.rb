# class_getters_setters.rb

# Agenda
# why classes?
# creating a class
# instance variables / attributes
# getters / setters
# methods

# Defining a class 
class Cat
  def initialize(name, color, age) # attribute
    @name = name
    @color = color
    @age = age
  end

  def name
    @name
  end

  # getter method
  def age
    @age
  end

  # setter method
  def age=(new_age)
    @age = new_age
  end

  def color
    @color
  end

  def meow_at(person)
    puts "#{@name} meows at #{person}"
  end
end

# initialize an instance of Cat
cat_1 = Cat.new("Lizzy", "white", 3) # cat_1 is object, an instance of the class Cat
puts cat_1.age
cat_1.meow_at("Julie")

puts cat_1.age = 7
puts cat_1.age=(66) # can omit parentheses, but want to keep in for clarity if possible
puts cat_1.age=42 # example of above, works
puts

cat_2 = Cat.new("Pusheen", "gray", 6)
puts cat_2.name
cat_2.meow_at("Julie")