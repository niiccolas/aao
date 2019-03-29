## Class Basics

### Motivation

Before we learn about classes, let's get motivated! Why should we use classes and what advantages do they offer?

#### How to Create Cats Poorly

As a programmer, you'll often want to model some object and the properties of that object. For example, a social media site may need to model a User with their username and a profile picture. Or perhaps a music site may need to model a Song with it's title, genre, and duration. Following App Academy tradition, let's say we wanted to model some Cats in ruby! Our Cats will have names, colors, and ages:

    cat_1 = {name: "Sennacy", color: "brown", age: 3}
    cat_2 = {name: "Whiskers", color: "white", age: 5}
    cat_3 = {name: "Garfield", color: "orange", age: 7}

Above we used hashes to represent our Cats. This seems like a fair choice, because we can use the key:value pairs of hashes to represent the properties of our Cats. For example `cat_1` has a `name` of `"Sennacy"` and an `color` of `"brown"`. Now, imagine we wanted to create a thousand Cats. We would have to tediously create each hash with the same keys of `name`, `color`, and `age`. This leaves a lot of opportunity for typos. We want to follow the DRY rule (**D**on't **R**epeat **Y**ourself) and improve this code. By using a class we can avoid this repetition and easily create objects of the same structure.

### Creating a Cat Class

In the cat example above, we can notice a theme across all Cats we create. They all have the same keys, but may differ in their values. We can say that each Cat has the same structure. Let's DRY up the last example by creating a Class to act as a blueprint for Cats.

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end
    end

A few things we'll want to note about the code above:

*   to create a class we use the `class` keyword, big surprise
*   the name of a class must begin with a capital letter
*   we can define methods within a class

You'll notice that we defined a method named `initialize` in our class. This is a special method name that we will use when creating cats. The method expects 3 parameters, which is nothing new, but what are `@name`, `@color`, etc.? `@` is how we denote a _instance variable_ or _attribute_ of our class. That means that our cat's will have the attributes or properties of `@name`, `@color`, `@age`.

#### Initializing New Cats

Now that we have a Cat class, we have a blueprint that can easily create Cats for us. Let's put it to use:

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 3)
    cat_2 = Cat.new("Whiskers", "white", 5)
    p cat_1 #<Cat:0x007fb6d804cfe0 @age=3, @color="brown", @name="Sennacy">
    p cat_2 #<Cat:0x007fb6d6bb60b8 @age=5, @color="white", @name="Whiskers">

Let's recognize something a bit strange about this code: To create a Cat we must call `Cat.new`, this must mean that `new` is a method on `Cat`. This is strange because nowhere did we define a method literally named `new`. The trick is, when we call `Cat.new`, ruby will be really calling upon the `initialize` method we defined. A hint at this is the fact that the `initialize` method expects a name, color, age and when we call `Cat.new` we pass in a name, color, age. You're probably wondering why the heck we can't just call `Cat.initialize`; it seems way more logical right??? The short answer to that is because reasons. This is something we'll have to accept blindly for now: _Cat.new will execute our initialize method_. As we explore more about classes we promise to explain the weirdness behind `new` and `initialize`.

With that out of the way, let's get to the punchline. When we call `Cat.new("Sennacy", "brown", 3)`, it will return an object to us that we store in the variable `cat_1`. Notice that the object contains the attributes that result from executing `initialize`. If we want to create more cats we simply call `Cat.new` again, passing in any name, color, age we please. We can use our `Cat` class to create any number of `Cat` instances. This means that `cat_1` and `cat_2` are instances of `Cat`.

Notice that when we print out an instance of a class, the notation will show which class this instance belongs to and a unique id for this object: `<Cat:0x007fb6d804cfe0...`

#### Getter Methods

Since we designed a Cat instance to consist of 4 attributes, it's common to also want a way to refer to the value of those attributes. To do this, we define "Getter Methods" to get (return) those attributes. Let's add a name getter to `Cat`:

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      def get_name
        @name
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 3)
    p cat_1.get_name # "Sennacy"

Notice that we defined another method called `get_name` in our class. To call this method, we must call it on a Cat instance, not directly on the Cat class! This makes sense because `cat_1` is an instance, so it refers to a particular cat. If we had done `Cat.get_name` we would be incorrectly trying to get the name of the blueprint. `Cat` is just the blueprint, so it does not refer to any single, particular cat. In summary we should call `cat_1.get_name` and not `Cat.get_name`.

By convention, getter methods typically have the same name as the attribute they are returning. So instead of defining `get_name`, we'll simply define `name`. Let's add another getter using this convention:

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      def name
        @name
      end

      def age
        @age
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 3)
    p cat_1.name  # "Sennacy"
    p cat_1.age   # 3

    cat_2 = Cat.new("Whiskers", "white", 5)
    p cat_2.name  # "Whiskers"
    p cat_2.age   # 5

    p cat_2.color # This will give NoMethodError: undefined method `color'

Cool, so we can now refer to the name and age of any Cat instance! Note that if we don't create a getter for a particular attribute, we won't have a way to refer to that attribute. Such as in the example above, we cannot refer to a Cat's color because we did not create the corresponding getter.

A final thought about getter methods, because they simply return the value of an attribute, we cannot use them to modify the @attribute. So we cannot use a getter method to change a cat's age.

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      def name
        @name
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 3)
    p cat_1.name          # "Sennacy"
    cat_1.name = "Kitty"  # This will give NoMethodError: undefined method `name='

To do accomplish this behavior we'll need to learn about setter methods next!

#### Setter Methods

Let's see what happens when we try to assign to an attribute of a Cat instance without the proper method in place. The following code will not work:

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      # getter
      def age
        @age
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 3)
    cat_1.age = 42  # NoMethodError: undefined method `age='

The error we get above suggests that we need to have a `age=` method on our Cat class. What a strange method name! Let's implement it:

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      # getter
      def age
        @age
      end

      # setter
      def age=(number)
        @age = number
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 3)
    p cat_1 #<Cat:0x007f8511a6f340 @age=3, @color="brown", @name="Sennacy">
    cat_1.age = 42
    p cat_1 #<Cat:0x007f8511a6f340 @age=42, @color="brown", @name="Sennacy">

Now we have a working method that we can use to change the age! Great. But something that feels uncomfortable here is how we call the method with `cat_1.age = 42`. If `age=` is the method name, then what's up with the space between `age` and `=`, as well as the lack of parentheses around our `42` arg? This doesn't seem like a proper method call, but it truly is! The following two method calls are equivalent

    cat_1.age=(42)
    cat_1.age = 42

For setter methods especially, we'll prefer the second version because the syntax is cleaner. Ruby is a quite flexible language. In general you are not required to use parentheses around arguments when making a method call. Try it for yourself: `"aeiou".include?("e")` is equivalent to `"aeiou".include? "e"`. As a matter of style and convention, we'll only omit parentheses for method calls that don't take in args or are special exceptions like a classic setter method.

### Beyond Getters and Setters

Getters and setters are common methods to implement on a class, but we can implement any arbitrary method we please on a class. The possibilities are endless:

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      def purr
        if @age > 5
          puts @name.upcase + " goes purrrrrr..."
        else
          puts "..."
        end
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 10)
    cat_1.purr  # "SENNACY goes purrrrrr..."

    cat_2 = Cat.new("Whiskers", "white", 3)
    cat_2.purr  # "..."

[http://www.sennacy.com/](http://www.sennacy.com/)

<br />

## Instance vs Class Variables

In our exploration of classes so far we have used plenty of **instance variables** or **attributes**. Similar to how we can have _class methods_ we can also have _class variables_. Let's compare the two.

### Instance Variables

Like we learned previously, `instance variables` are denoted with `@` and are typically assigned inside `#initialize`:

    class Car
      def initialize(color)
        @color = color
      end

      def color
        @color
      end
    end

    car_1 = Car.new("red")
    p car_1.color     # "red"

    car_2 = Car.new("black")
    p car_2.color     # "black"

Nothing new here. If we want cars to vary in the property of color, then we simply make the relevant instance variable for `@color`. Great, but what if we wanted to have a property that is shared among all cars? Let's accomplish this next using a class variable.

### Class Variables

Let's say we wanted all car instances to have the same number of wheels. We can add a class variable `@@num_wheels`:

    class Car
      @@num_wheels = 4

      def initialize(color)
        @color = color
      end

      # getter for @color instance variable
      def color
        @color
      end

      # getter for @@num_wheels class variable
      def num_wheels
        @@num_wheels
      end
    end

    car_1 = Car.new("red")
    p car_1.num_wheels    # 4

    car_2 = Car.new("black")
    p car_2.num_wheels    # 4

Notice that we use `@@` to denote class variables and typically assign these variables right inside of the class, but _not_ inside of `#initialize`. This means that any car instance we create will be able to refer to this single, shared `@@num_wheels` variable. An important distinction to have in mind is that instances `car_1` and `car_2` have their own/separate `@color` variables, but share a single `@@num_wheels` variable.

As a result of all instances sharing this single variable, a change to this variable will effect all instances. Let's create a class method that sets `@@num_wheels`:

    class Car
      @@num_wheels = 4

      def self.upgrade_to_flying_cars
        @@num_wheels = 0
      end

      def initialize(color)
        @color = color
      end

      def num_wheels
        @@num_wheels
      end
    end

    car_1 = Car.new("red")
    car_2 = Car.new("black")

    p car_1.num_wheels    # 4
    p car_2.num_wheels    # 4

    Car.upgrade_to_flying_cars

    p car_1.num_wheels    # 0
    p car_2.num_wheels    # 0

    car_3 = Car.new("silver")
    p car_3.num_wheels    # 0

The future is now! Changing class variables is really powerful since it effects every instance that we created and _will create in the future_ (see `car_3` above). However, with great power comes great responsibility, so be very cautious when writing such code.

### Class Constants

Often times, we'll want to prevent class variables from being changed for safety. In this scenario we'll want to create a **class constant** instead. As it's name suggests, a constant cannot be reassigned. Let's redo the last example with a class constant:

    class Car
      NUM_WHEELS = 4

      def self.upgrade_to_flying_cars
        NUM_WHEELS = 0    # SyntaxError: dynamic constant assignment
      end

      def initialize(color)
        @color = color
      end

      def num_wheels
        NUM_WHEELS
      end
    end

    car_1 = Car.new("red")
    car_2 = Car.new("black")

    p car_1.num_wheels    # 4
    p car_2.num_wheels    # 4

    Car.upgrade_to_flying_cars

Class constant names must be capitalized. Notice that reassigning the constant will fail with an error, exactly what we wanted!

## Wrapping Up

*   an `@instance_variable` will be a distinct variable in each instance of a class; changing the variable will only effect that one instance
*   a `@@class_variable` will be shared among all instances of a class; changing the variable will effect all instances because all instances of the class
*   a `CLASS_CONSTANT` will be shared among all instances of a class, but cannot be changed

<br/>

## Instance Methods vs Class Methods

Now that we have the basics of classes down, let's explore two different methods we may build into class: **instance methods** and **class methods**.

### Instance Methods

So far we've been only dealing with instance methods with our classes. Like it's name suggests, an instance method is one that is called on an _instance_ of a class. Let's check out an instance method:

    class Dog
      def initialize(name, bark)
        @name = name
        @bark = bark
      end

      def speak
        @name + " says " + @bark
      end
    end

    my_dog = Dog.new("Fido", "woof")
    my_dog.speak          # "Fido says woof"

    other_dog = Dog.new("Doge", "much bork")
    other_dog.speak       # "Doge says much bork"

`speak` is an instance method because we can only call it on a `Dog` instance we initialized using `Dog.new`. Remember that if something is an instance of `Dog`, it is an object with a `@name` and `@bark`. Since `my_dog` and `other_dog` are instances, when we call `speak` on them respectively, we can get different behavior because they can have different `@name` and `@bark` values. An instance method depends on the _attributes_ or _instance variables_ of an instance.

For notation, we'll use **Dog#speak** to denote that `speak` is an **instance method** of `Dog`

### Class Methods

A class method is a method that is called directly on the class. Let's see how to define a class method:

    class Dog
      def initialize(name, bark)
        @name = name
        @bark = bark
      end

      def self.growl
        "Grrrrr"
      end
    end

    Dog.growl   # Grrrrr

Notice that we define class method by adding `self.` to the front of a method name. In this context, `self` refers to the `Dog` class itself. Since `growl` is a class method, we cannot call it on an instance; instead we call it on the `Dog` class directly . A class method cannot refer to any instance attributes like `@name` and `@bark`! As programmers, we'll choose to build class methods for added utility.

For notation we'll use **Dog::growl** to denote that `growl` is an **class method** of `Dog`.

For example, here is a class method that is a bit more practical, `Dog::whos_louder` :

    class Dog
      def initialize(name, bark)
        @name = name
        @bark = bark
      end

      def self.whos_louder(dog_1, dog_2)
        if dog_1.bark.length > dog_2.bark.length
          return dog_1.name
        elsif dog_1.bark.length < dog_2.bark.length
          return dog_2.name
        else
          return nil
        end
      end

      def name
        @name
      end

      def bark
        @bark
      end
    end

    d1 = Dog.new("Fido", "woof")
    d2 = Dog.new("Doge", "much bork")
    p Dog.whos_louder(d1, d2) # "Doge"

You may be wondering why we prefer to make `Dog::whos_louder` a class method. We make this choice because the code inside of the method does not pertain to a single instance of dog, meaning it does not refer to instance attributes of `@name`, `@bark`.

## Wrapping Up

*   `Class#method_name` means `method_name` is an instance method
*   `Class::method_name` means `method_name` is a class method



<br/>
