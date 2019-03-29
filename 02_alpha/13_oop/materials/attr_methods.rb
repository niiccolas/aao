# attr_reader - defines getter methods
# attr_reader - defines setter methods
# attr_accessor - defines both getters and setters


class Dog
  # attr_reader :name, :age
  # attr_writer :name, :age
  attr_accessor :name, :age

  def initialize(name, age, favorite_food)
    @name = name
    @age = age
    @favorite_food = favorite_food
  end

end

my_dog = Dog.new("Fido", 2, "pizza")
puts my_dog.name
puts my_dog.age = 3