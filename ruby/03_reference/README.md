# References

In the Ruby language variables hold **references** to objects.

    my_object = Object.new
    # my_object now refers to a new instance of Object

    my_object = Object.new
    # a new Object instance is created, and the my_object variable is
    # reassigned so that it now refers to this object, rather than the old
    # object.

    # call `my_method` on the object that `my_object` refers to
    my_object.my_method

One point is that `=` does not **mutate** (modify) an object; it merely **reassigns** the variable so that it now refers to a new object.

Here is another example.

    def add_to_array!(array, item)
      array << item
    end

    my_array = []
    add_to_array!(my_array, "an item!")
    p my_array

This code will modify the array referred to by `my_array`. When we call `add_to_array`, we're passing it a reference to the same object referred to by `my_array`, as well as a reference to the literal string `"an item!"`. So inside `add_to_array`, the variable `array` refers to the same object that `my_array` refers to outside the method. So modifications to the array inside the method will be visible outside.

## The `[]=` and accessor methods

We've said that `=` never modifies an object, and merely reassigns a variable to refer to a new object. But then how do I explain this:

    my_hash = {}
    # add a key & value to the hash
    my_hash[:key] = :value

How does this work? Notice that we aren't just assigning to a variable; we're asking to mutate `my_hash` so that `:key` will refer to `:value` now. To do this, Ruby calls the `[]=` method on the hash. Here's how it might be defined:

    class Hash
      def []=(key, val)
        # code to set key so that it maps to value...
      end
    end

In fact, we can even write this with the usual method call notation:

    my_hash.[]=(:key, :value)

Other writer methods work similarly:

    class Cat
      attr_accessor :name
    end

    my_cat = Cat.new
    my_cat.name = "Breakfast" # == my_cat.name=("Breakfast")

Conveniences like this (the ability to write `hash[:key] = :value` instead of `hash.[]=(:key, :value)`) are called _syntactic sugar_. They don't change the fundamental way the language works; they are merely shortcuts to make things a little easier on us.

## `+=` and `!=`

One last bit of syntactic sugar is to discuss how Ruby interprets `+=` and `!=`. This is done quite simply

    x += y # => x = x + y, will work as long as `#+` is defined
    x != y # => !(x == y), will use the `#==` method

So while `[]=` was a method, `+=` and `!=` are pure syntactic sugar. Ruby will translate them into code that calls `+` and `==` respectively.

## The or trick

The Ruby `||` operation does something called short circuiting:

    true || this_code_is_not_run
    false || this_code_will_be_run

Ruby is sort of lazy; it won't evaluate the right side if the left side of `||` is already true. That makes sense, because regardless of what the right side is, the whole or statement will always be true. Ruby understands this, and so as a special rule won't execute more than it needs to.

Ruby will return the first "truthy" value from the or:

    (1 || 2) == 1
    (nil || 5) == 5

There's an "or trick" that uses `||=`:

    class MemoizedFibonacci
      def initialize
        @values = {}
      end

      def fib(n)
        @values[n] ||= calculate_fib(n)
        # expands to:
        #     @values[n] = @values[n] || calculate_fib(n)
        # if @values[n] is nil (not previously computed), will call
        # `calculate_fib` and store the result for later reference.
      end

      private
      def calculate_fib(n)
        case n
        when 0
          0
        when 1
          1
        else
          fib(n - 1) + fib(n - 2)
        end
      end
    end

  <br/>

  # Array/Hash Defaults

## Arrays of Arrays

Here's a very common problem that everyone will run into. Let's say we want to make an array of arrays:

    [4] pry(main)> arr_of_arrs = Array.new(3, [])
    => [[], [], []]
    [5] pry(main)> arr_of_arrs[0] << "a"
    => ["a"]
    [6] pry(main)> arr_of_arrs
    => [["a"], ["a"], ["a"]]

Wait, what happened? We added `"a"` to the first array, but all of them were modified?

The reason is that only **two** arrays are created in the example: (1) `arr_of_arrs`, (2) the single empty array passed into the `Array` constructor (`[]`). `arr_of_arrs` stores three **references** to the same empty array.

Thus, when you access the array at position `0` and mutate it, you're mutating the same array referenced by position at one and two.

The way to solve this problem is like so:

    [7] pry(main)> arr_of_arrs = Array.new(3) { Array.new }
    => [[], [], []]
    [8] pry(main)> arr_of_arrs[0] << "a"
    => ["a"]
    [9] pry(main)> arr_of_arrs
    => [["a"], [], []]

Here, instead of passing a reference to a single empty array (which would be stored at three locations), we've passed a block. The block will be run to produce a value to store for each position in the array. The block constructs a new array each time it is run.

I wrote `Array.new` in the block to make it clear that a new array is constructed each time the block is executed, but you could equivalently write `[]` in the block.

## Mutable vs Immutable

Okay, we've seen that arrays store references to objects. We've seen a naive problem where we stored several references to the same object. Since all references refer to the same underlying object, a mutation through one reference (`arr_of_arrs[0] << "a"`) is also visible through another reference (`arr_of_arrs[1] == ["a"]`).

You may have previously written code like this:

    arr2 = Array.new(3, 1)

    arr2[0] += 1
    arr2[0] == 2
    arr2[1] == 1
    arr2[2] == 1

Does this contradict what we've just discussed about references and mutations? Why isn't the change visible at position `1`?

Let's unpack `arr2[0] += 1`. This is Ruby shorthand for:

    arr2[0] = arr2[0] + 1

Let's further break this into steps:

1.  First, fetch the number at position 0 (which is `1`).
2.  Next, add one to this number. **This creates a new number object**. The `+` operation **does not** mutate the original object.
3.  Finally, assign a reference to the new object (`2`) to position `0` of `arr`.

The trick is that we **never mutate** any number. We produce a new one and reset `arr2[0]` to refer to the new object. That's why none of the other indices are affected.

The `Fixnum` and `Float` classes are called **immutable**. None of their methods modify data inside the `Fixnum`/`Float`; they produce new values instead. `nil` is another example.

## Hash default values

Providing a default value for a Hash has the same issues as with an Array:

    [1] pry(main)> cats = Hash.new([])
    => {}
    [2] pry(main)> cats["Devon"]
    => []
    [3] pry(main)> cats
    => {}

Providing an argument to `Hash.new` merely changes what is returned when we look up a key that isn't present in the hash. Note how this doesn't assign a value to `"Devon"` through mere access of the key. To do that, we can do something like:

    [4] pry(main)> cats["Devon"] += ["Earl"]
    => ["Earl"]
    [5] pry(main)> cats
    => {"Devon"=>["Earl"]}
    [6] pry(main)> cats["Devon"] += ["Breakfast"]
    => ["Earl", "Breakfast"]
    [7] pry(main)> cats
    => {"Devon"=>["Earl", "Breakfast"]}

Better. `cats["Devon"] += ["Earl"]` means `cats["Devon"] = cats["Devon"] + ["Earl"]`. This constructs a new array and stores it for key `"Devon"`

But what about this?

    [7] pry(main)> cats = Hash.new([])
    => {}
    [8] pry(main)> cats["John"] << "Kiki"
    => ["Kiki"]
    [9] pry(main)> cats
    => {}
    [10] pry(main)> cats["Raul"]
    => ["Kiki"]

Let's think through what's happening here. On line 8, we try to get a value for `cats["John"]`. `"John"` is not a key in the hash, so the default (an empty array) is returned. We then mutate the default value by adding `"Kiki"` to it.

We never set a value for `"John"` though, so this is not stored in the Hash (see the result of line 9).

Later, when we try to access some other non-present key (`"Raul"`), the default value is returned again. But since we mutated the value by shovelling `"Kiki"` in, this is no longer empty. This is bad, because we never meant for `"Raul"` to own `"Kiki"`.

We can start to fix the problem as before:

    [11] pry(main)> cats2 = Hash.new() { [] }
    => {}
    [12] pry(main)> cats2["Devon"] << "Breakfast"
    => ["Breakfast"]
    [13] pry(main)> cats2["George"]
    => []

Hash will use the block to produce a new default value each time. Modifying the value won't have an affect on looking up other non-existent keys, since we create a new value each time, instead of reusing a single default object.

But we have the other problem again: we're still not setting a value.

    [16] pry(main)> cats2
    => {}

Let's fix this:

    [17] pry(main)> cats3 = Hash.new { |h, k| h[k] = [] }
    => {}
    [18] pry(main)> cats3["Devon"]
    => []
    [19] pry(main)> cats3
    => {"Devon"=>[]}
    [20] pry(main)> cats3["John"] << "Kiki"
    => ["Kiki"]
    [21] pry(main)> cats3
    => {"Devon"=>[], "John"=>["Kiki"]}

Here we've modified the block to take two arguments: when Hash needs a default value, it will pass itself (`h`) and the key (`k`). The block will not only create an empty array, but also assign it to the hash.

You can see one somewhat funny side-effect when we look up `"Devon"`; even when we just want to lookup a value, if it is not present we'll incur the side-effect of mutating the hash (the key `"Devon"` got added).

<br/>


# Scope

[Scope](http://en.wikipedia.org/wiki/Scope_(computer_science)) is the context in which a variable name is valid and can be used.

A name is **in scope** (accessible) if the name has been previously defined in the current method (called a **local variable**) or at a higher level of the current method. A new level starts whenever we begin a class, a method, or a block.

We can't use a variable before it is defined:

    def pow(base, exponent)
      i = 0
      while i < exponent
        result = result * base  # Error: result is being used before it has been defined.

        i += 1
      end

      result
    end

We can't use a variable from a deeper scope. In the below example, `cat_age` is defined inside `extract_cat_age` and not available at the top-level scope.

    # defines a cat variable name in the global scope
    cat = {
      :name => "Breakfast",
      :age => 8
    }

    def extract_cat_age
      # creates a new local variable inside this method; won't add
      # variable to global scope; variable will be lost when method is
      # over

      cat_age = cat[:age]
    end

    extract_cat_age
    cat_age # ERROR: variable out of scope

Sometimes things are subtle:

    def fourth_power(i)
      square(i) * square(i)   # wait, isn't square not defined yet?
    end

    def square(i)
      i * i
    end

    # Ah, but by the time we _call_ `fourth_power` and run the
    # interior code, `square` will have been defined.

    fourth_power(2)

## Global variables

**_NOTE:_** This last bit about global variables is not essential.

While you shouldn't typically create global variables, you can do so with the `<section class="sc-ipXKqB eevSDq sc-hEsumM fwPWBm" prefix.

You can also create file-local global variables by defining a variable without `<section class="sc-ipXKqB eevSDq sc-hEsumM fwPWBm" at the top-level (outside any block, method, class). However, file-local global variable won't be accessible to other Ruby files that load the file.

<br/>


In _The Pragmatic Programmer_, Hunt and Thomas define the DRY principle as follows:

> Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.

In other words: don't repeat yourself!

The most common way to avoid repetition is to break duplicated code into methods.

    def process_consumer_address_form(fields)
      unless fields[:zip] =~ /[1-9][0-9]{4}/
        raise InvalidZipCodeError
      end

      # more form processing
    end

    def process_business_address_form(fields)
      unless fields[:zip] =~ /[1-9][0-9]{4}/
        raise InvalidZipCodeError
      end

      # more form processing
    end

See how we've repeated the bit that checks that the zip code is valid? This is bad; if there were a bug with our zip code validation, we'd have to fix the code **in two places**. This is a pain, and we'll probably forget to fix the duplicated code everywhere, so it's also a source of bugs. For this reason, we want to find a way to eliminate the duplicated code:

    def process_consumer_address_form(fields)
      raise InvalidZipCodeError unless valid_zip?(fields[:zip])
      # more form processing
    end

    def process_business_address_form(fields)
      raise InvalidZipCodeError unless valid_zip?(fields[:zip])
      # more form processing
    end

    def valid_zip?(zip)
      zip =~ /[1-9][0-9]{4}/
    end

Breaking the duplicated code into a method has the side-effect of making the consumer/business methods shorter and more focused on the details of checking the form, rather than the details of zip code validation.

A good rule of thumb with DRY is that if you find yourself copying and pasting code into other places, you should most likely refactor to avoid duplication.

<br/>

# Method Decomposition & Design

## Methods should be atomic

**Each method should do one thing.** A method should do a single, atomic thing (this is sometimes called the _Single Responsibility Principle_). This may be one line of code, or three, but rarely more than ten. **Methods should be short.** Let's take a look at an example of refactoring one long method into short, atomic methods, **NB** this is sometimes called "iterative stiffening". We'll use an implementation of the Towers of Hanoi exercise we worked on in the array section.

Here's the problem description in case you don't remember it:

    Write a Towers of Hanoi game.

    Keep three arrays, which represents the piles of discs. Pick a representation 
    of the discs to store in the arrays; maybe just a number representing their size.

    In a loop, prompt the user (using gets) and ask what pile to select a disc 
    from, and where to put it.

    After each move, check to see if they have succeeded in moving all the discs, 
    to the final pile. If so, they win!

Here's an example of a one-method solution:

    def hanoi
      disks = (1..3).to_a.reverse
      stacks = [disks, [], []]
      until stacks[0].empty? && stacks[1..2].any?(&:empty?)
        max_height = stacks.map(&:count).max
        render_string = (max_height - 1).downto(0).map do |height|
          stacks.map do |stack|
            stack[height] || " "
          end.join("\t")
        end.join("\n")
        puts render_string
        move_hash = { "a" => 0, "b" => 1, "c" => 2 }
        while true
          print "Move From: "
          from_stack_num = move_hash[gets.chomp]
          break unless from_stack_num.nil?
          puts "Invalid move!"
        end
        while true
          print "Move To: "
          to_stack_num = move_hash[gets.chomp]
          break unless to_stack_num.nil?
          puts "Invalid move!"
        end
        from_stack, to_stack = stacks.values_at(from_stack_num, to_stack_num)
        raise "cannot move from empty stack" if from_stack.empty?
        unless (to_stack.empty? || to_stack.last > from_stack.last)
          raise "cannot move onto smaller disk"
        end
        to_stack.push(from_stack.pop)
      end
      puts "You did it!"
    end

Let's start breaking this method into smaller methods. What are the steps that we take in this one fairly long method?

1.  Set up a stack of disks
2.  Set up a set of 3 stacks
3.  Loop until its over
4.  Display the stacks
5.  Get move to position
6.  Get move from position
7.  Move the disk while checking to see if move is valid

Now that we've listed the atomic steps, it will be easy to split the method into smaller methods. Let's go step by step, and start by extracting the `disks` method:

    def disks
      (1..3).to_a.reverse
    end

    def hanoi
      stacks = [disks, [], []]
      # ...

Notice that the `disks` method has _one_ job of returning a stack of disks.

Lets extract stacks into a method that builds the stacks using disks.

    def disks
      (1..3).to_a.reverse
    end

    def stacks
      [disks, [], []]
    end

    def hanoi
      until stacks[0].empty? && stacks[1..2].any?(&:empty?)
      # ...

Notice that stacks has one job of building the stacks from the disks.

Now we're looping until the game is over, but it looks like this over condition is starting to get a bit complex. Lets break out over into its own method.

    def over?
      stacks[0].empty? && stacks[1..2].any?(&:empty?)
    end

    def hanoi
      until over?
      # ...

While we're taking turns moving disks we'll probably want to display the current state of the board each time. Extracting that block of code might look like this:

    def display
      max_height = stacks.map(&:count).max
      render_string = (max_height - 1).downto(0).map do |height|
        stacks.map do |stack|
          stack[height] || " "
        end.join("\t")
      end.join("\n")
    end

    def hanoi
      until over?
        puts display
        # ...

The next step is to get the from and to stacks. This logic for getting a stack is mostly the same, less the prompt. We can write a method that takes a prompt as an argument.

    def get_stack(prompt)
      move_hash = { "a" => 0, "b" => 1, "c" => 2 }
      while true
        print prompt
        stack_num = move_hash[gets.chomp]
        return stack_num unless stack_num.nil?
        puts "Invalid move!"
      end
    end

    def hanoi
      until over?
        puts display
        from_stack_num = get_stack("Move from: ")
        to_stack_num = get_stack("Move to: ")
        from_stack, to_stack = @stacks.values_at(from_stack_num, to_stack_num)
        raise "cannot move from empty stack" if from_stack.empty?
        unless (to_stack.empty? || to_stack.last > from_stack.last)
          raise "cannot move onto smaller disk"
        end
        to_stack.push(from_stack.pop)
      # ...

Our methods are starting to look leaner :). The next step is to extract the work of moving the disk into its own `move_disk` method.

    def move_disk(from_stack, to_stack)
      from_stack, to_stack = @stacks.values_at(from_stack_num, to_stack_num)
      raise "cannot move from empty stack" if from_stack.empty?
      unless (to_stack.empty? || to_stack.last > from_stack.last)
        raise "cannot move onto smaller disk"
      end
      to_stack.push(from_stack.pop)
    end

    def hanoi
      until over?
        puts display
        from_stack = get_stack("Move from: ")
        to_stack = get_stack("Move to: ")
        move_disk(from_stack, to_stack)
      end
    end

**It reads like plain English.** Hiding away our implementation details in well-named helper methods both reduced the length of `hanoi` and made its structure more transparent. If somebody looks at this code, they will immediately understand what is going on, even without reading the definitions of `get_stack` and `move_disk`. This makes it a lot easier to understand code.

If they are interested in the implementation of a _specific action_, they know where to find it: localized to an atomic, helper method.

## Do not use global state

A good general goal is that your methods should be like a mathematical function: it should take something in and return something. It should not rely on anything besides what is explicitly passed in, and it should not have side-effects; it should communicate its result through the return value.

Some languages are stricter than Ruby: they don't allow you to use any data except what is passed in as an argument, and they don't let you change any outside ("global") variables variables, or communicate outside except through the return value. Ruby is more flexible, but the majority of methods should be written in this style.

Simply put: **the only way in should be the arguments, the only way out should be the return value**.

Here's an example of something super terrible:

    # create a global i variable
    $i = nil

    def square_then_add_two(num)
      $i = num
      square

      $i = $i + 2
    end

    def square
      # get global variable, square it, and reset
      $i = $i * $i

      nil
    end

First, `square` relies on a _global_ variable. This should have been passed in directly. Everything that a method needs should be declared up-front as a parameter to the method. This makes it easier to know how to call the method: just pass in the listed arguments.

Second, `square` doesn't return anything useful; instead, it communicates by setting a global variable. That is unnecessarily convoluted; just give the answer back directly.

A general guideline, avoid global state. Don't use global variables to get around passing in arguments or return values. I basically never use `<section class="sc-ipXKqB eevSDq sc-hEsumM fwPWBm" variables.

## Don't modify arguments

Callers do not typically expect you to modify an argument. For instance:

    def combine_ingredients(alcohols, mixers)
      drinks = []

      alcohols.length.times do
        drinks << [alcohols.pop, mixers.pop]
      end

      drinks
    end

This destroys the caller's arrays. Did they expect this? If modification of the argument is essential to what you're doing, fine, but otherwise don't do something potentially unexpected and dangerous like this.

Instead do something like:

    def combine_ingredients(alcohols, mixers)
      drinks = []

      alcohols.each_index do |i|
        drinks << [alcohols[i], mixers[i]]
      end

      drinks
    end

## Resources

*   [Wikipedia: Side effect](http://en.wikipedia.org/wiki/Side_effect_(computer_science))
*   [Destructuring with Ruby](http://tony.pitluga.com/2011/08/08/destructuring-with-ruby.html)

<br/>

# Refactoring (code smells)

From the [Wiki](http://en.wikipedia.org/wiki/Code_smell):

`A code smell is any symptom in the source code of a program that possibly indicates a deeper problem. Code smells are usually not bugs — they are not technically incorrect and don't currently prevent the program from functioning. Instead, they indicate weaknesses in design that may be slowing down development or increasing the risk of bugs or failures in the future ... a code smell is a driver for refactoring.`

We list a few kinds of smells here here:

**Duplicated/similar code**: see the [reading](dry-don-t-repeat-yourself) on DRY code. Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/ruby/readings/dry.md).

**Long methods**: see the [reading](method-decomposition-design) on method decomposition. Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/ruby/readings/method-decomposition.md).

**Too many parameters**: The more parameters a method has, the greater the chance that it is too coupled to code that invokes it. Many parameters may also be a sign of an excessively complex method.

**Data clump**: if you see a group of data always being passed around together, this is usually a good candidate for refactoring out into an object. For example `start_date` and `end_date` might be pulled out into a `date_range` object.

**Long method chains**: long method chains can often be a sign that you're violating the [Law of Demeter](http://en.wikipedia.org/wiki/Law_Of_Demeter): only talk to your "neighbors", only use one dot.

    bicycle.front_tire.rotate
    bicycle.rear_tire.rotate

    # vs
    bicycle.rotate_tires

The idea is that instead of reaching into objects (like the `bicycle`) and calling methods on their "internals" (`front_tire` and `rear_tire`), we should create a method that will take care of this for us (`rotate_tires`). This helps us organize our code, and prevents us from becoming too dependent on the internal structure of other objects.

LoD has disadvantages (see the wiki article); if taken too literally you end up with overly wide interfaces. However, the longer your method chains get, the more likely you should apply LoD.

**Indecent Exposure**: Classes should share the bare minimum interface with the outside world. If you don't have a compelling reason to make a method or variable public, hide it. Other classes will interact with the public surface of the class; any change to the public surface will necessitate changes to interacting classes. Minimizing exposure will better enable change.

[From the wiki page:](http://en.wikipedia.org/wiki/Coupling_(computer_programming)) "Coupling (dependency) is the degree to which each program module relies on each one of the other modules."

Indecent exposure may result in coupling that is too tight. The more extensive your classes' interface, the more tightly other classes can latch on to it.

A complicated interface can also signal a class that is doing too much. Probably there's an opportunity to break out responsibilities to other classes.

We want to minimize the amount of coupling between our classes and objects. To understand how tightly coupled your classes are, ask yourself if you changed the internals of one class, would you have to change things in the other? If you do, you've likely coupled the two classes too tightly.

**Speculative Generality**: Follow the principle of [YAGNI](http://en.wikipedia.org/wiki/You_ain't_gonna_need_it) ('You ain't gonna need it'). New devs often waste time thinking of all the ways they might "generalize" their code so that it's easy to make this change or that change, so that they can support all sorts of new features easily, etc., etc. This can result in a very complicated design, before any business need for those features even exists.

More importantly, it is very, very hard to get a speculative design like this right. Good design happens when there are clear requirements and concrete examples to think about; it's hard to make a perfect design for some hazy, poorly understood future. Don't solve _abstract_ problems: wait until you have a _concrete_ problem.

**God object**: A god object is one that is very tightly connected to all the other objects in the system. Good OO design results in classes that are lightly coupled. A good class delegates responsibility as necessary to other objects; it shouldn't need to know everything about what every other object is doing (omniscience), and it shouldn't micromanage how other objects manage their responsibilities. Nothing in your program usually needs to even know about the existence of everything else.

**Dead code**: don't leave commented-out (or otherwise unused) code in your code base. This is why we have version control (we'll learn about git soon!). Clean up after yourself!

## Clean Code

When push comes to shove, sometimes you need to make compromises; when deadlines hit, we all ship code we aren't 100% proud of. Still, endeavor to write clean code. Pay attention to style. Pay attention to code organization. Pay attention to code smells. Refactor often and aggressively. Bask in the beauty of clean code. Take pride in it.

## Further Reading

*   Enjoy watching Ben Orenstein's classic talk: [Refactoring: From Good to Great](http://www.confreaks.com/videos/1233-aloharuby2012-refactoring-from-good-to-great).

<br/>

# Overview of HTML/CSS Curriculum

At App Academy you will learn many things about Ruby, Rails, JavaScript and React+Redux. All of these things are programmatic and similar in nature, but there are other important aspects of web-development besides being a l33t hacker and they include presentation and design. Presentation and design are captured by HTML (structure) and CSS (styling).

Instead of trying to cover a very broad topic over the course of a few days we will be learning HTML and CSS incrementally over the course of the first three weeks of the curriculum. For these three weeks we will start most days (excluding assessments) with a short (about 15 minutes) HTML/CSS exercise to review the topics covered the night before. These will be very simple and are an _excellent_ time to ask TAs questions about the material.

We will kick off week 4 with a full-day HTML/CSS project to review all the material we've covered thus far. At the end of the day we aim to have a good handle on the HTML and CSS principles and continue to practice as we progress

<br/>


## Front-end Development

Front-end development can be split up into three major coding languages.

**HTML** - HyperText Markup Language defines the structure of a website semantically and the content that will be rendered by the web browser.

**CSS** - Cascading Stylesheets deal with the presentation of content including aspects such as layout, formatting and colors.

**Javascript** - One of the most popular coding languages in the world, brings movement and user interaction to websites.

This Curriculum focuses on the first two cornerstones of modern front-end development: HTML & CSS.

## HTML

HyperText Markup Language is made up of HTML Elements denoted using opening and closing tags:

    <p>This is an example of a paragraph element in HTML</p>

These elements form the building blocks of an HTML document and may either directly introduce content or wrap content to provide information about document text.

For example, the above `<p></p>` tags wrap the containing document text into an HTML Element. The `<img/>` tag below is self-closing in that it does not wrap anything but instead directly inputs the provided image as an HTML Element.

    <img src="appacademy.io/images/app-academy-logo.img" />

Notice that this image tag received additional information by declaring what is called an **attribute**. Attributes receive **values** in double quotes. The `src` attribute provides a url to the image tag for the browser to get and render the proper image inside the HTML Element. Mastering the various tags and attributes is the first key to becoming proficient in HTML.

## Tags

The following are examples of popular tags in HTML and how they are used.

### Paragraphs and Headings

    <p>A paragraph tag is used to wrap a multi-line body of text</p>

    <h1>A heading1 tag is used to denote the largest title on the page</h1>

**N.B.** The `<h1>` tag is used in site ranking algorithms by search engines such as Google. It is important to only have one `<h1>` element per page and to have it contain a keyword summarizing the page content.

    <h2>Used for titles with a smaller font size than h1</h2>

These heading tags should be used in descending order with regards to their containing font sizes. The smallest size is a:

    <h6>Heading six tag</h6>

### Lists

Lists are used to contain a series of list elements. These may be ordered or unordered but must contain at least one element. There are three different types of HTML list tags. The following is an example of the first, most common type, the unordered list.

    <ul>
        <li>Unordered List</li>
        <li>Ordered List</li>
        <li>Definition List</li>
    </ul>

The ordered list is usually used to display numbered list elements.

    <ol>
        <li>First</li>
        <li>Second</li>
        <li>Third</li>
    </ol>

The definition list it not as common but is used to hold definition data and term elements.

    <dl>
        <dt>Unordered List</dt>
        <dd>An HTML element made up of list elements in no particular order</dd>
        <dt>Ordered List</dt>
        <dd>An HTML element made up of list elements in order</dd>
        <dt>Definiton List</dt>
        <dd>An HTML element with definition term and definition data elements</dd>
    </dl>

### Links

What is commonly referred to around the internet as a "link" is a clickable element that directs the browser to another page or area on the page. This is not to be confused with a link tag, which will be discussed in future sections.

To create a link using an html element we use what is called an anchor tag:

    <a href="http://appacademy.io">App Academy</a>

Notice that the URL for which this clickable anchor tag element will make a GET request to is provided through an href attribute. The text within the anchor tag element is the what appears as clickable on the page.

In the following code we create two anchor tags. One is self-closing with a name attribute and the other contains text that has an href attribute with the same name value preceded by a `#`. This is how we create in-page links. Clicking the 'Back to top' link wherever it is placed on the page will now take the user to the location of the named anchor tag.

    <a name="top-of-page" />
        <!-- Imagine all of your other content in between. By the way, this is how we denote comments in HTML. -->
    <a href="#top-of-page">Back to top</a> 

The use of the `#` in the beginning of the url tells the browser to find an element on the page with the given name attribute instead of making a new GET request.

### Images

We create image elements in HTML using a self-closing image tag with the `src` attribute referring to the path to the image data.

    `<img src="http://appacademy.io/images/app-academy-logo.img" alt="app-academy-logo" />`

The `alt` attribute provides alternate text for the image which is used in image search rankings, speech-accessibility, and displayed when a user hovers over the image.

# Testing Small

(Note: This reading assumes familiarity with the Memory Puzzle project.)

Make a sample card to play around with. Open up pry and make a new card (something like `card = Card.new`). In your code, play around with how you assign variables.

For example:

      def hide
        face_up = false
      end

Reload your code. In pry, call `card.hide` and see what happens. Does it change the way you expected?

      def hide
        self.face_up = false
      end

Reload your code. In pry, call `card.hide` and see what happens. Does it change the way you expected?

      def hide
        @face_up = false
      end

Reload your code. In pry, call `card.hide` and see what happens. Does it change the way you expected?

What's the difference between the different ways of writing the method? You might have to google for the subtle differences.

The overall goal here is to **test your code out with simple examples**.

If you can test one card on its own, it's a lot easier than trying to test the card through other code. In this case, you shouldn't test `card.hide` by calling a different method that calls `card.hide` inside.

For example, it would be hard to test `card.hide` by calling the method below. There's too much stuff to wade through:

      class Board
        #...

        def update_cards
          puts "updating the cards"
          self.repopulate
          # a bunch of other methods

          @cards.each do |card|
            @grid << card
            card.flip
            # a bunch of other methods

            card.hide #the actual line we want to test
          end
        end

      end

      board = Board.new
      board.update_cards
      board.render

There's way too much going on for your brain to easily tell when card.hide **actually** gets called. And it's hard to tell if anything else is changing `face_up` on the card. Instead, try to test one card on its own.

Benefits: You saved at least five minutes by testing small instead of hacking through a huge block of buggy code. You have to test your code many times a day (almost every time you make a change). Imagine that savings multiplied over and over. You're saving **hours** of your day by testing small.


### Projects:

* [Memory Puzzle]()
* [Intro to HTML]()
* [Sudoku]()
