class Dog
  def initialize(name, breed, age, bark, favorite_foods)
    @name = name
    @breed = breed
    @age = age
    @bark = bark
    @favorite_foods = favorite_foods
  end

  # Getters
  attr_reader :name
  attr_reader :breed
  attr_reader :age
  attr_reader :favorite_foods

  # Setters
  attr_writer :age

  # Instance methods
  def bark
    return @bark.downcase if @age <= 3

    @bark.upcase
  end

  def favorite_food?(str)
    favorite_foods.map(&:downcase).include? str.downcase
  end
end

# fav_foods = ['Canned Meat', 'Sausage', 'T-bone', 'Jello']
# snoop = Dog.new('snoop', 'Labradawg', 2, 'Woop Woop!', fav_foods)

# puts snoop.favorite_food?('t-bone')   # => true
# puts snoop.favorite_food?('macaroni') # => false

# puts "#{snoop.name} is #{snoop.age} years old".capitalize # => 2
# puts snoop.bark # => 'woopwoop!'

# snoop.age = 7
# puts "#{snoop.name} is #{snoop.age} years old".capitalize # => 7
# puts snoop.bark # => 'WOOPWOOP!'
