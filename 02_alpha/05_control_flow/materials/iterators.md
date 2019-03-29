# Iterators

## Goals

*   Know that iterators are preferred over `while` and why that is.
    *   Understand that anything that can be accomplished with an iterator can still be accomplished with `while`
*   Know when you might want to use `Array#each_with_index` instead of `#each`.
*   Know how to use `Integer#times` to execute a block multiple times.
*   Know what a `Range` is.
    *   Know how we can use a `Range` to iterate through a range of index values, without using `while`.

While it's possible to traverse a collection (such as an array or range) using loops, the Ruby community greatly prefers iterators. An **iterator** is a method that repeats a set of instructions once for each element in its receiver. Iterators are methods that handle looping automatically, making your code simpler and easier to read.

The most important iterator is `each`. These two traversals are functionally equivalent, but `each` is far more elegant:

    traverse_me = [1, 2, 3]

    # using a while loop
    idx = 0
    while idx < traverse_me.length
      puts traverse_me[idx]
      idx += 1
    end

    # using the each iterator
    traverse_me.each { |el| puts el }

The biggest advantage of `each` is that you don't have to keep track of an index variable. This may not seem like a big deal, but every line of code you don't have to write is one less to debug. One of the most common programming errors is to forget to increment the index variable each time, creating an unintended infinite loop:

    i = 0
    while i < 5
      puts "Do this five times"

      # forgot: i += 1
    end
    puts "This code will never execute"

Using `each` avoids this problem entirely.

## A Quick Primer on Blocks

`{ |el| puts el }` is an example of a **block**, a way of grouping instructions that's denoted by enclosing curly braces (`{}`) or `do` and `end` keywords. Blocks are like functions without names attached to them (programmers commonly refer to this as an _anonymous function_.) They receive arguments at the start of the block and execute a series of statements using those arguments. The arguments are comma-separated and enclosed in pipes (`||`). Convention is to use curly braces to denote single-line blocks and `do` and `end` to denote multiline ones:

    ("a".."z").each do |char| # you can use iterators with arrays or ranges
      puts "I'm such a funny character!"
      puts "Look at me: #{char}!"
    end

So what is this block doing next to `each`? The block acts as a pseudo-argument. `each` accepts a block that it invokes once for each element in the receiver collection, passing that element to the block as an argument. When `each` finishes iterating (when it reaches the end of the collection), it returns the receiver. In other words, _`each` returns the array that it was originally called on_:

    traverse_me_again_please = [1, 2, 3]
    traverse_me_again_please.each {|el| puts el} #=> [1, 2, 3]

<span><iframe src="https://player.vimeo.com/video/182464455" width="100%" height="400px" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen="" style="line-height: 1.6em;" rel="line-height: 1.6em;"></iframe></span>

## Closures

One of the principal differences between methods and blocks is that blocks are **closures**, which basically means that they capture or "close over" variables from the outer context in which they are defined. Closures are like one-way scope gates: a closure can access variables from the scope above it, but the upper scope does not have access to variables defined inside the closure. This block can reference and manipulate the `str` variable because it's defined in the same scope where the block itself is defined (that of the method `devowel!`):

    def devowel!(str)
      ["a", "e", "i", "o", "u"].each do |vowel|
        str.delete!(vowel)
        str.delete!(vowel.upcase)
      end
      str
    end

    the_funkiest = "funky monkey"
    devowel!(the_funkiest) #=> "fnky mnky"
    the_funkiest #=> "fnky mnky" (this method modifies its argument)

Conversely, attempting to access a variable defined within the block from outside of it results in an error, namely `undefined local variable or method 'last_vowel'`:

    def erroneous_devowel!(str)
      ["a", "e", "i", "o", "u"].each do |vowel|
        # The last_vowel variable will be reassigned in each iteration.
        # It's final value will be "u".
        last_vowel = vowel
        str.delete!(vowel)
        str.delete!(vowel.upcase)
      end
      puts "The last vowel I tried to devowel was #{last_vowel}!"
      str
    end

    the_flunkiest = "flunky monkey"
    erroneous_devowel!(the_flunkiest) # Invoking the method causes the error.

## Range

A range is exactly what it sounds like:

    (1..10)

This represents all the numbers from 1 through 10\. A range with two dots goes up to and includes the second number. A range with three dots excludes the second number. For example, (0...10) goes from 0 to 9, and does not include 10\. We can iterate over ranges just like we iterated over arrays:

    (1..10).each do |i|
      puts i * i
    end

Note that ranges cannot go from a larger value to a smaller value (i.e. `10..1`). One alternative is to convert the range to an array and reverse it:

    (1..10).to_a.reverse.each do |i|
      puts i
    end

In this case, it probably makes more sense to use [`Integer#downto`](http://ruby-doc.org/core-2.3.1/Integer.html#method-i-downto).

## Next and Break

The `next` and `break` keywords have the same effect in iterators as in loops. Here's a non-dangerous (i.e., non-mutating) version of the previous method that uses the `next` keyword.

    def devowel(str)
      vowels = ["a", "e", "i", "o", "u"]
      new_str = ""

      # We turn the string into an array of characters using chars.
      # An alternative to this is the method each_char (covered below!)
      str.chars.each do |ch|
        next if vowels.include?(ch.downcase)
        # the code below is only reachable when ch is a consonant
        new_str += ch
      end

      new_str
    end

    forever_the_funkiest = "funky monkey"
    devowel(forever_the_funkiest) #=> "fnky mnky"
    forever_the_funkiest #=> "funky monkey" (this method does not modify its argument)

## Other Essential Iterators

### times

If all you want to do is repeat some code several times, use Ruby's `times` method:

    5.times do
      puts "King of the streets; child at play"
    end

Again, you get to avoid an index variable.

### each_with_index

`each` is cleaner than `while`, but sometimes you also need the index of each element. In this case, you should use `each_with_index`:

    my_favorite_number = 42
    numbers = [42, 3, 42, 5]

    favorite_indices = []
    numbers.each_with_index do |number, index|
      if number == my_favorite_number
        favorite_indices << index
      end
    end

`each_with_index` combines the simplicity of `each` with the ability to reference an index.

### each_index

The `each_index` method uses the same syntax as `each`, but it passes the block each index as an argument (rather than the element itself). Like `each`, it returns its receiver.

    traversed_thrice_is_all_right = [1, 2, 3]
    traversed_thrice_is_all_right.each_index do |idx|
      puts "my argument is #{idx}"
      puts traversed_thrice_is_all_right[idx]
    end #=> [1, 2, 3]

You'll need to use `each_index` rather than `each` in order to access and reassign elements in the receiver array (since `each` only passes in a copy of each element into the block, we cannot modify the original receiver without accessing the index directly):

    double_me_darling = [1, 2, 3]
    double_me_darling.each_index do |idx|
      # this is syntactic sugar for double_me_darling[idx] = double_me_darling[idx] * 2
      double_me_darling[idx] *= 2
    end

    double_me_darling #=> [2, 4, 6]

### each_char

The `each_char` method is essentially the `each` of strings. As its name suggests, it invokes its given block once for each character in the receiver string, passing that character as an argument. It returns its receiver.

    # like puts, print prints its argument, but it doesn't insert a newline after printing
    "alright alright alright".each_char {|ch| print ch.upcase} #=> "alright alright alright"

    # note the difference when executed
    "alright alright alright".each_char {|ch| puts ch.upcase} #=> "alright alright alright"

Most iterators belong to a set of methods known as enumerables, which are the subject of the next chapter.

### each vs for

Ruby also has a `for` loop construct:

    for item in items
      # ...
    end

For idiomatic reasons, `for` is not recommended for use. You'll see plenty of Python code use `for` this way, but in Ruby we'll satisfy ourselves with using `#each`.

## Resources

*   [Skorks on looping](http://www.skorks.com/2009/09/a-wealth-of-ruby-loops-and-iterators)
*   More examples of loops on [tutorialspoint](http://www.tutorialspoint.com/ruby/ruby_loops.htm)
