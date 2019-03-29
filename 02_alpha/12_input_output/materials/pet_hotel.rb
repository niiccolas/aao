# pet_hotel.rb
# general rule of organization, keep classes in separate files

# ./ means in the same location (folder) as this file
require_relative "./cat.rb"
require_relative "./other animals/dog.rb"

class PetHotel
  def initialize(name)
    @name = name
    @guests = []
  end

  def check_in(guest)
    @guests << guest
  end
end

# class Cat
#   def initialize(name)
#     @name = name
#   end
# end

hotel = PetHotel.new("Animal Inn")

cat_1 = Cat.new("Lizzy")
cat_2 = Cat.new("Chauncy")
dog_1 = Dog.new("Snoopy")

hotel.check_in(cat_1)
hotel.check_in(cat_2)
hotel.check_in(dog_1)

p hotel

# p var
# var needs to be capitalized (as constants are recognized as such when first letter is capitalized) in order to be accessible outside of the Cat class in another file
p Var