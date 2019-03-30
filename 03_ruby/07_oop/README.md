# Inheritance

## Goals

*   Know how to extend a class.
*   Know how to override a method.
*   Know how to call the original method.

## Extending Classes

Inheritance is a way to establish a subtype from an existing class in order to reuse code. Let's look at an example:

    class User
      attr_reader :first_name, :last_name

      def initialize(first_name, last_name)
        @first_name, @last_name = first_name, last_name
      end

      def full_name
        "#{first_name} #{last_name}"
      end

      def upvote_article(article)
        article.upvotes += 1
      end
    end

    class SuperUser < User
      attr_reader :super_powers

      def initialize(first_name, last_name, super_powers)
        super(first_name, last_name)
        @super_powers = super_powers
      end

      def upvote_article(article)
        # extra votes
        article.upvotes += 3
      end

      def delete_user(user)
        return unless super_powers.include?(:user_deletion)

        # super user is authorized to delete user
        puts "Goodbye, #{user.full_name}!"
      end
    end

Here we use `<` to denote that the `SuperUser` class **inherits** from the `User` class. That means that the `SuperUser` class gets all of the methods of the `User` class. We say that `User` is the **parent class** or **superclass**, and that `SuperUser` is the **child class** or **subclass**. So we can write code like so:

    [13] pry(main)> load 'test.rb'
    => true
    [14] pry(main)> u = User.new("Jamis", "Buck")
    => #<User:0x007f9ba9897d98 @first_name="Jamis", @last_name="Buck">
    [15] pry(main)> u.full_name
    => "Jamis Buck"
    [16] pry(main)> su = SuperUser.new("David", "Heinemeier Hansson", [:user_deletion])
    => #<SuperUser:0x007f9ba98e66c8
     @first_name="David",
     @last_name="Heinemeier Hansson",
     @super_powers=[:user_deletion]>
    [17] pry(main)> su.full_name
    => "David Heinemeier Hansson"
    [18] pry(main)> su.delete_user(u)
    Goodbye, Jamis Buck!
    => nil

`SuperUser` **overrides** some of `User`'s methods: `initialize` and `upvote_article`. The definitions in `SuperUser` will be called instead.

In the case of `initialize`, the `SuperUser` method will call the original definition in `User`. This is done through the call of `super`, which runs the parent class's version of the current method.

Calls to `super` are especially common when overriding `initialize`.

## Inheritance and Code Reuse

Inheritance has allowed us to avoid duplicating the methods that are common to `User` and `SuperUser`. Here's another example:

    class Magazine
      attr_accessor :editor
    end

    class Book
      attr_accessor :editor
    end

We see code being duplicated: a bad sign. We can use inheritance to solve this problem like so:

    class Publication
      attr_accessor :editor
    end

    class Magazine < Publication
    end

    class Book < Publication
    end

This is a toy example, but the more two classes have in common the more it pays for them to share a single base class. This also makes it easier to add new child classes later.

Of course, the `Magazine` and `Book` classes may have their own methods in addition to the shared `editor` method.

## Calling a super method

When overriding a method, it is common to call the original implementation. We can call the superclass's implementation of any method using the special `super` keyword. There are two major ways in which `super` is called. If super is called without any arguments, the arguments passed to the method will be implicitly passed on to the parent class's implementation.

    class Animal
      def make_n_noises(n = 2)
        n.times { print "Growl " }
      end
    end

    class Liger < Animal
      def make_n_noises(num = 4)
        num.times { print "Roar " }
        # here we'll call super without any arguments. This will pass on `num`
        # implicitly to super. You can think of this call to super as:
        # `super(num)`
        super
      end
    end

    Liger.new.make_n_noises(3) # => Roar Roar Roar Growl Growl Growl

The most common method where this happens is `initialize`. Consider this setup and try to spot the problem:

    class Animal
      attr_reader :species

      def initialize(species)
        @species = species
      end
    end

    class Human < Animal
      attr_reader :name

      def initialize(name)
        @name = name
      end
    end

Uh-oh! When we call `Human.new`, this won't set the species! Let's fix that. Here is the second major way that super is called, passing arguments explicitly:

    class Animal
      attr_reader :species

      def initialize(species)
        @species = species
      end
    end

    class Human < Animal
      attr_reader :name

      def initialize(name)
        # super calls the original definition of the method
        # If we hadn't passed "Homo Sapiens" to super, then `name` would have
        # been passed by default.
        super("Homo Sapiens")
        @name = name
      end
    end

<br/>

# Exceptions

## Goal

*   Know when to use exceptions.
*   Know how to raise an exception. Know how to handle one.
*   Know how to run some code regardless of an exception being thrown.

## Basics

Things don't always work out the way you plan. Sometimes your code will experience an error. Exceptions are the means of telling the caller that your code can't do what was asked.

    def sqrt(num)
      unless num >= 0
        raise ArgumentError.new "Cannot take sqrt of negative number"
      end

      # code to calculate square root...
    end

Since we can't take the square root of a negative number, we **raise** an **exception** instead of returning an answer. When an exception is raised, the method stops executing. Instead of returning, an exception is thrown. The method's caller then gets a chance to handle the exception:

    def main
      # run the main program in a loop
      while true
        # get an integer from the user
        puts "Please input a number"
        num = gets.to_i

        begin
          sqrt(num)
        rescue ArgumentError => e
          puts "Couldn't take the square root of #{num}"
          puts "Error was: #{e.message}"
        end
      end
    end

If the user feeds in a negative number, `sqrt` will raise an exception. Because `main` has wrapped this code in a begin/rescue/end block, the exception will be **caught**. The code will jump to the rescue block that anticipates an `ArgumentError`. It will save the exception in the variable `e`, then run the error handling code.

If the calling method doesn't rescue (we also say **catch** or **handle**) an exception, it continues to **bubble up** the **call stack**. So the caller's caller gets a chance, then their caller, then...

If no method throughout the entire call stack catches the exception, the exception is printed to the user and the program exits.

## Ensure

Sometimes there is important code that must be executed whether an exception is raised or otherwise. In this case, we can use `ensure`.

    begin
      a_dangerous_operation
    rescue StandardError => e
      puts "Something went wrong: #{e.message}"
    ensure
      puts "No matter what, make sure to execute this!"
    end

A common example is closing files:

    f = File.open
    begin
      f << a_dangerous_operation
    ensure
      # must. close. file.
      f.close
    end

## Retry

A common response to an error is to try, try again.

    def prompt_name
      puts "Please input a name:"
      # split name on spaces
      name_parts = gets.chomp.split

      if name_parts.count != 2
        raise "Uh-oh, finnicky parsing!"
      end

      name_parts
    end

    def echo_name
      begin
        fname, lname = prompt_name

        puts "Hello #{fname} of #{lname}"
      rescue
        puts "Please only use two names."
        retry
      end
    end

The `retry` keyword will cause Ruby to repeat the `begin` block from the beginning. It is useful for "looping" until an operation completes successfuly.

## Implicit Begin Blocks

Method and class definitions are implicitly wrapped in a `begin`/`end` block, so if your error handling applies to the whole method, all you have to add is `rescue`.

    def slope(pos1, pos2)
      (pos2.y - pos1.y) / (pos2.x - pos1.x)
    rescue ZeroDivisionError
      nil
    end

The method from the `retry` example could also be written this way.

    def echo_name
      fname, lname = prompt_name

      puts "Hello #{fname} of #{lname}"
    rescue
      puts "Please only use two names."
      retry
    end

## Exception Hierarchy

There are a number of predefined exception classes in Ruby. You can find them [here](http://blog.nicksieger.com/articles/2006/09/06/rubys-exception-hierarchy). You should try to choose an appropriate class. One of the more common exceptions to use is `ArgumentError`, which signals that an argument passed to a method is invalid. `RuntimeError` is used for generic errors; this is probably your other goto.

When creating an exception, you can add an error message so the user knows what went wrong:

    raise RuntimeError.new("Didn't try hard enough")

If you want your user to be able to distinguish different failure types (perhaps to handle them differently), you can extend `StandardError` and write your own:

    class EngineStalledError < StandardError
    end

    class CollisionOccurredError < StandardError
    end

    def drive_car
      # engine may stall, collision may occur
    end

    begin
      drive_car
    rescue EngineStalledError => e
      puts "Rescued from engine stalled!"
    rescue CollisionOccurredError => e
      puts "Rescued from collision!"
    ensure
      puts "Car stopped."
    end

## Don't go crazy

Exceptions are a great tool for handling unexpected errors. But once you have a hammer, you may find yourself starting to look for nails.

Writing durable, "hardened" code means thinking of everything that could go wrong, watching out for those issues, and throwing an exception in that case. For instance, when writing `sqrt`, we can think ahead and recognize that negative numbers are a problem. So we add code to check this, and throw an exception.

Likewise, durable code anticipates exceptions being thrown. It makes sure that exceptions are handled properly. It avoids the program crashing; it does everything possible so that the program may carry on in spite of the exception.

However, writing hardened code like this is tedious and slow. There are always many, many things that could go wrong, and you could spend a ton of time writing exception classes, raise errors, making sure to catch them, etc.

For this reason, raise exceptions sparingly until you are hardening a project. Focus on driving out the functionality first. And don't waste your time imagining perverse scenarios; assume for the moment that the universe doesn't hate you. Just consider the things that could reasonably go wrong. You can always add more exception-handling code later.

Remember the maxim: _you ain't gonna need it_. Wait to implement functionality when you need it, not when you anticipate it. Features that aren't required take time away from more important requirements. But more importantly, they are often poorly conceived, because until you have a practical need for a feature, you're just trying to imagine how that feature should work.

<br/>

# Decomposition into Objects

So far, when we've tackled programming problems, we've tried to break up the problem into methods; small bits of code that do one thing. This helps us manage the complexity of a complex task by breaking it into smaller, easily understood and digested tasks.

Object oriented design is another way to decompose complex problems. Imagine a simulation of minnows and sharks: each "turn", the minnow swim away from the shark, the shark swims after the closest minnow.

When decomposing a problem into objects, we look for the nouns; those are good candidates to use as a class (the verbs often end up as methods). Here, we could create a `Minnow` class and a `Shark` class.

    class Minnow
    end

    class Shark
    end

A `Minnow` and a `Shark` swim differently. They should both have a `#swim` method, but they should do different things.

    class Minnow
      def swim
        # swim away from any sharks
      end
    end

    class Shark
      def swim
        # swim toward closest fish
      end
    end

Finally, each `Minnow` and `Shark` have a position in the aquarium:

    class Minnow
      attr_reader :position

      def initialize(initial_position)
        # save the minnow's initial position
        @position = initial_position
      end

      def swim
        # swim away from any sharks; update @position
      end
    end

Notice what we've done here: each `Minnow` or `Shark` keeps track of its own position. Stored information like a `Minnow`'s position is called the _state_ of an object. `Minnow`s and `Shark`s have their own way of doing things (they both `#swim` differently); this is called _behavior_.

Object oriented design is about breaking a complex problem down into classes, each of which is responsible for its own state and behavior. This lets us write our `Minnow` code mostly in isolation of code for the `Shark` or an `Aquarium` or `Fisherman`. Writing code in this way not only makes it more modular (and thus extensible), but breaking the problem down into sub-problems makes each piece easier to reason about.

## Choosing the right level of granularity

We've said that we should "look for the nouns" when deciding what classes to define. But how do we choose the nouns? In our Shark/Minnow problem, why is `Shark` and `Minnow` the right level of granularity, and not an `Aquarium` class that is responsible for modeling both sharks and fishes?

Each class should do one thing. An `Aquarium` tries to do two things: model fish and model sharks.

How do we decide what a single responsibility is? The best way to think about it is this: you should define classes at the level of abstraction that you want to make changes at. You might want to make changes to the minnows, but not the sharks, so they should be separate classes. Jeff Atwood [explains](https://blog.codinghorror.com/curlys-law-do-one-thing/) this idea better than we can.

You will gain a better intuition about design as you read and write more code. As a beginner, watch out for the beginner's tendency to either to create classes that are responsible for way too many things (like `Aquarium`), or to create way too many small classes before they are needed (we don't need a `FishTail`, `FishEye`, etc. classes here).

Rule of thumb: a large class is >125 lines of code. Sometimes that's not a design mistake, but it's suspicious after that. 300+ lines is a behemoth. You should start looking for ways to break down a class that large.

<br/>

# Inheritance and DRY

When defining classes, we want to avoid duplicating code in their methods. For instance, imagine two classes, `Minnow` and `Shark`. Both of these classes might have a method `#eat`, like so:

    class Minnow
      def eat
        puts "eat eat eat"
      end
    end

    class Shark
      def eat
        puts "eat eat eat"
      end
    end

The _DRY principle_ ("Don't repeat yourself") tells us that we should try to remove this duplicated code, if possible. Inheritance will help us do that; we'll have `Minnow` and `Shark` inherit from a `Fish` parent class:

    class Fish
      def eat
        puts "eat eat eat"
      end
    end

    class Minnow < Fish
    end

    class Shark < Fish
    end

## Inheritance and Generic Code

Because `Minnow` and `Shark` are both different types of `Fish`, we can write _generic_ code that can process any kind of `Fish`, and it will work with both `Minnow`s and `Shark`s. Here's an example with many types of employee.

    class Employee
      def wage
        20_000
      end
    end

    class Manager < Employee
      def wage
        50_000
      end
    end

    class CEO < Manager
      def wage
        1_000_000
      end
    end

    # calculate the total salary of many employees
    def total_salary(employees)
      total = 0
      employees.each do |employee|
        # Don't know/care what kind of `Employee` (regular, Manager,
        # or CEO) this is. We can treat them all the same.
        total += employee.wage
      end
    end

## Don't go crazy

Don't introduce subclasses before you need them. In the example of `Employee`/`Manager` we were a little aggressive; we could have had just one `Worker` class and a variable that held the `@wage` of the `Worker`.

A good guideline to follow is not to introduce a new subclass until:

*   You are facing two different subclasses of the base class, AND
*   The two subclasses have substantially different behavior.

In short, don't use inheritance until it serves a purpose like keeping your code DRY or helping code organization. Needlessly complicated inheritance hierarchies are a common mistake of novice programmers.

<br/>

# Information hiding

## Private Methods

In Ruby, we can mark specific methods in our classes as **private**. When we do so, the only way to access those methods is from within the class itself. Here's an example of what that looks like:

    class Airplane
      def fly
        start_engine
        ...
      end

      private
      def start_engine
        ...
      end
    end

All methods after the [`private`](http://ruby-doc.org/core-2.5.1/Module.html#method-i-private) keyword are private to the class.

What kind of methods should be `private`? Ones which users of the class should not call, either for safety reasons (user doesn't know when they should `start_engine`) or because they're low-level details that don't concern them (user just wants to `fly`, doesn't want to know how that happens).

Instance variables are always "private" in the sense that they are not even methods. You can expose instance variables to the outside world by making public getter/setter methods using [`attr_accessor`](http://ruby-doc.org/core-2.5.1/Module.html#method-i-attr_accessor) and the like.

## Shy Code

We mentioned safety and a simple interface as reasons that you might want to create private methods. Also, you want to make it easy to change and extend your code. The more you expose to users of the class (whether people or other code), the more they will rely on those details. Whatever you expose will be that much harder to change later after others depend on it.

The point of object orientation is to present a simple interface, abstracting away the details inside the method implementations. Code that is too permissive breaks those abstractions, leaking internal concerns to the outside world. For instance, if we let a user call `start_engines`, now they need to remember to later call `stop_engines`. This makes it harder to use our class.

A good guiding principle of OO design is: minimize the interfaces between your classes; expose the least possible amount of state and behavior, and have a good reason for every piece of information that you expose.

That said, if you miss a method that should be private but is instead public, it won't be a disaster. Myself, I focus on catching cases where a method is obviously internal to the workings of the class. Robust code ready to release to the outside world should eventually be checked for proper use of `private`, though.

<br/>

# Unified Modeling Language

Unified Modeling Language (UML) is a visual way of describing the relationships between different objects in a system. UML can describe classes (e.g., the structure of an object-oriented software program) or behavior (e.g., diagramming a set of concurrent processes). We will be using UML to model the class structure of our chess game.

In UML, classes can be related to each other in several different ways, including `parent-child` and `association` (a "has a" relationship). `Piece` is the parent of `Pawn`, for example, while `Game` is associated with `Board` because `Game` has a (i.e. `requires`) `Board`.

A class is usually drawn in UML with three components: a name, a set of attributes (instance variables), and a set of methods. The attributes and methods are marked as being public (+), private(-), or protected (#), and class methods are underlined.

## Example

Take a look at this [diagram](http://assets.aaonline.io/fullstack/ruby/assets/Chess_Diagram.png) for our chess implementation.

<br/>

### Links:

* [Ruby Documentation - Singleton](http://ruby-doc.org/stdlib-1.9.3/libdoc/singleton/rdoc/Singleton.html#module-Singleton-label-Usage) 


### Projects:
* [Error Handling Funtime]()
* [Class Inheritance]()
* [Chess (Part One)]()
