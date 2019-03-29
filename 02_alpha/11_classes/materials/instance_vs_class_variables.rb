# instance_vs_class_variables.rb

# Agenda 
# - instance variables (attributes), every instance of class will have the same value for instance variable, because you are creating a class constant
# - class variables, single variable shared among all instances of your class

class Car
  #@@num_wheels = 4  # class variable
  NUM_WHEELS = 4 # class constant

  # getter for @color instance variable
  def initialize(color)
    @color = color
  end

  # def self.upgrade
  #   @@num_wheels = 0
  # end

  # getter for @@num_wheels class variable
  def num_wheels
    # @@num_wheels
    NUM_WHEELS
  end
end

car_1 = Car.new("silver")
car_2 = Car.new("blue")

# Car.upgrade 
# will change every instance - to not have this happen, can create class constant (a variable that cannot be reassigned, all uppercase)

p car_1.num_wheels
p car_2.num_wheels

car_3 = Car.new("black")
p car_3.num_wheels


# @instance_variable - a distinct variable in each instance of a class; changing the variable will only effect that one instance
# @@class_variable - shared among all instances of a class; changing the variable will effect all instances because all instances of the class
# CLASS_CONSTANT - shared among all instances of a class, but cannot be changed