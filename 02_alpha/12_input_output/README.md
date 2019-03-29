# Input/Output

## Requiring Files

As our programs grow more and more complex, we'll want to separate code into many files. This will help our code stay organized and easy to maintain. We've been using this organization a bit so far in the course: we often separate our test code (spec files) from our actual implementation files. In the previous RSPEC based projects, you may have noticed the `/spec` and `/lib` folders found in each project root. Let's step through an example of how we can divide our code into files!

### Enter Pet Hotel

Using the previous concept of classes, let's design a `PetHotel` that will house `Cat`s as guests. Let's begin by writing both classes in the same file:

    # pet_hotel.rb

    class PetHotel
      def initialize(name)
        @name = name
        @guests = []
      end

      def check_in(guest)
        @guests << guest
      end
    end

    class Cat
      def initialize(name)
        @name = name
      end
    end

    hotel = PetHotel.new("Animal Inn")

    cat_1 = Cat.new("Sennacy")
    cat_2 = Cat.new("Whiskers")

    hotel.check_in(cat_1)
    hotel.check_in(cat_2)

    p hotel
    # <PetHotel:0x007fb1ce1e91f0
    #   @name="Animal Inn",
    #   @guests=[
    #     #<Cat:0x007fb1ce1e9060 @name="Sennacy">,
    #     #<Cat:0x007fb1ce1e8f48 @name="Whiskers">
    #   ]
    # >

The code above seems acceptable, but what if our `PetHotel` and `Cat` classes were more complex? Grouping these two classes in the same file may no longer be viable. Even further, what if our `PetHotel` should be able to house other animals like `Dog`s, `Bird`s, etc.? We should avoid creating one massive file for all of this classes and logic. A great design principle to follow is _Separation of Concerns_. One file should focus on implementing one class. After all, our `Cat` class should be able to stand on it's own without interaction from `PetHotel`. Let's decouple `Cat` from `PetHotel` to increase reusability of our classes.

### A Better Hotel design

Below is one way we could organize our different files. `project_root` is our outermost folder that will contain everything. Names that end in `.rb` are files, names that don't end in `.rb` are folders:

    project_root
      ├── pet_hotel.rb
      ├── cat.rb
      └── other_animals
          └── dog.rb

However, if `PetHotel` and `Cat` exist in separate files, how can we connect the two? We need to "import" `cat.rb` into `pet_hotel.rb`. In other words, we need to require `cat.rb` in `pet_hotel.rb`. Let's take a look into how we can do this along with `dog.rb`, using the `require_relative` method next.

#### Require Relative

Keep in mind the folder structure above and take a look at the code we could have in each file:

    # project_root/cat.rb
    class Cat
      def initialize(name)
        @name = name
      end
    end

    # project_root/other_animals/dog.rb
    class Dog
      def initialize(name)
        @name = name
      end
    end

    # project_root/pet_hotel.rb

    # Let's require the last two files, by specifying their path's relative to this pet_hotel.rb file
    require_relative "./cat.rb"
    require_relative "./other_animals/dog.rb"

    class PetHotel
      def initialize(name)
        @name = name
        @guests = []
      end

      def check_in(guest)
        @guests << guest
      end
    end

    hotel = PetHotel.new("Animal Inn")

    cat = Cat.new("Sennacy")
    dog = Dog.new("Fido")

    hotel.check_in(cat)
    hotel.check_in(dog)

    p hotel
    # <PetHotel:0x007ffe7f01af60
    #   @name="Animal Inn",
    #   @guests=[
    #     #<Cat:0x007ffe7f01aee8 @name="Sennacy">,
    #     #<Dog:0x007ffe7f01ae98 @name="Fido">
    #   ]
    # >

To run our hotel, we would just need to execute `ruby pet_hotel.rb`. Because `pet_hotel.rb` requires `cat.rb` and `dog.rb`, the code in those files will also execute.

`require_relative` is a method we can use to specify a path to another ruby file. As it's name suggests, we need to specify a path that is relative to our current location. So if we are at `pet_hotel.rb` a relative path to `cat.rb` is `./cat.rb`. A single dot (`./`) denotes the current location of our file.

`dog.rb` is not immediately found in our current location; it is one folder away. So the relative path from `pet_hotel.rb` to `dog.rb` is `./other_animals/dog.rb`.

#### require vs require_relative

You may have noticed that in the course projects we have used `require` instead of `require_relative` in our `/spec` files. We use the plain `require` because we run the code using RSPEC via `bundle exec rspec`. RSPEC will automatically run the code in a certain configuration where it will automatically know to look inside of the `/lib` folder. In fact, RSPEC is designed to be used where you have a separate `/spec` and `/lib` folders. To get into the nitty gritty details, RSPEC will configure the $LOAD_PATH for us. But don't worry about this for now.

As a rule of thumb, we'll use the plain `require` where gems are involved. In the previous sections that used the byebug gem, we had to write `require "byebug"` to access the debugger. It's obvious that we don't have an explicit `byebug.rb` file in those old projects. This is because ruby already knows where to find byebug through the $LOADPATH.

<br/>

## User Input

So far in the course we have only written code that executes without any input from a user. In order to make our programs interactive, we'll need to learn how to allow the user to interact through their keyboard.

### Getting Input

The built in method we'll use to allow a user to give input is `gets`. The `gets` method is unique in that when it is called, it will halt execution of the code and allow the user to type characters until they press enter on their keyboard. Once enter is hit, the `gets` method will return a string containing the user's keystrokes. Let's take a look at `gets` in action:

    p "Enter your name:"
    name = gets
    p "hello " + name

The program above will ask a use to enter their name and then print "hello _name_". Try putting this code in a file and running it to see for yourself!

### Dealing with New Lines

When using `gets`, the string returned represents the keys typed by the user. However, since the user presses enter to end their input, this will add a newline character at the end of the string. `\n` is how we represent the newline character in programming. You'll notice that every string returned from `gets` will end in `\n` as a result of this. We should be very aware of this extra character when using gets. Here's a common mistake:

    puts "Enter 'yes' or 'no'"

    response = gets

    if response == "yes"
      puts "yup!"
    elsif response == "no"
      puts "nah!"
    else
      puts "I'm sorry, my responses are limited."
    end

As this codes stands, if the user enters a valid response of _yes_ the conditional would not be able to catch this. This is because `gets` will really return `"yes\n"`. `"yes"` is not equal to `"yes\n"`, bummer.

#### Chomping New Lines

To fix the issue in the previous code, we can use a string method, `chomp` to remove all newline chars (`\n`) at the end of a string by returning a new string. Note that `chomp` is just a plain string method:

    my_string = "yes\n"
    p my_string       # "yes\n"

    p my_string.chomp # "yes"

Since `gets` returns a string, let's `chomp` it in our old example. Here is the correct code:

    puts "Enter 'yes' or 'no'"

    response = gets.chomp

    if response == "yes"
      puts "yup!"
    elsif response == "no"
      puts "nah!"
    else
      puts "I'm sorry, my responses are limited."
    end

When the user responds with _yes_ or _no_, the code above will run accordingly.

### Getting Numbers

Another common mistake happens when we try to get number input from the user. Take a look at this faulty code:

    puts "Enter a number: "
    num = gets.chomp
    puts 2 * num      #TypeError: String can't be coerced into Integer

When the user enters a "number", the code will get an error because `gets` will always return a string of characters. So if the user intended to enter the number 42, `num` would really be the string "42".

#### Converting Strings to Numbers

To fix the previous error we'll use the `to_i` on strings. This method will convert a string **to** an **i**nteger:

    numeric_string = "42"
    p numeric_string      # "42"
    p numeric_string.to_i # 42

Let's apply this to the last example:

    puts "Enter a number: "
    num = gets.chomp.to_i
    puts 2 * num

If the user enters 42, the program will correctly print 84.

<br/>

### Projects:

* [Guessing Game](https://github.com/jlollis/AAA-AppAcademy/tree/master/02-Alpha/12-Input-Output/exercises/guessing-game/guessing_game_project)

* [Hangman](https://github.com/jlollis/AAA-AppAcademy/tree/master/02-Alpha/12-Input-Output/exercises/hangman/hangman_project)

* [Hotel](https://github.com/jlollis/AAA-AppAcademy/tree/master/02-Alpha/12-Input-Output/exercises/hotel/hotel_project)