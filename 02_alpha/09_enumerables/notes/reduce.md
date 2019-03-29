# Reduce

`reduce` is by far the most difficult enumerable to learn. It can be invoked in four ways:

1.  With one argument, a symbol that names a binary method or operator (e.g., `:+`, which takes two operands, or `:lcm`, which has a receiver and an argument).
2.  With two arguments, the first argument being the initial value for the accumulator, and the second argument being a symbol that names a binary method or operator (e.g., `:+`, which takes two operands, or `:lcm`, which has a receiver and an argument).
3.  With a block and without an argument. The block has two parameters: an accumulator and the current element.
4.  With a block and with one argument that's the initial accumulator. The block has two parameters: an accumulator and the current element.

In every variation, `reduce` combines all elements of its receiver by applying a binary operation. Let's examine each case.

## With a Symbol

What do these invocations of `reduce` do? How do the array's elements contribute to the return value?

    [1, 2].reduce(:+) #=> 3
    [1, 2].reduce(:*) #=> 2

    [1, 2, 3].reduce(:+) #=> 6
    [1, 2, 3].reduce(:*) #=> 6

When we pass `:+`, the return value is the _sum_ of all the elements in the array; when we pass `:*`, the return value is the _product_ of all the elements in the array. Each element in the receiver is passed to the method specified in the argument, but how exactly? In what order? The order in which the elements are passed might not matter for commutative operations like addition and multiplication, but it certainly matters if the argument is `:/`:

    [1.0, 2.0, 3.0].reduce(:/) #=> 0.16666666666666666
    [3.0, 2.0, 1.0].reduce(:/) #=> 1.5

Let's return to a simpler example: `[1, 2, 3].reduce(:+)`. The Ruby interpreter executes these steps under the hood:

1.  The interpreter stores the first element in the array as the initial value for the accumulator.
2.  The interpreter invokes the `+` operator because its name was passed as the argument. The accumulator (`1`) is the receiver and the next element in the array (`2`) is the argument (i.e., `1 + 2` or `1.+(2)`).
3.  The interpreter reassigns the accumulator to the return value of the addition in step 2 (`3`).
4.  The interpreter invokes the `+` operator again with the accumulator (`3`) as the receiver and the next element in the array (`3`) as the argument (i.e., `3 + 3` or `3.+(3)`).
5.  The interpreter reassigns the accumulator to the return value of the addition in step 4 (`6`).
6.  Because the array has no remaining elements, the interpreter returns the accumulator: `6`.

This method is analogous to `reduce(:+)`:

      def my_sum(arr)
        accumulator = arr.first # store first element as accumulator

        arr.each_index do |idx|
          next if idx == 0 # skip first element: it's already the accumulator
          accumulator += arr[idx] # increment accumulator by current element
        end

        accumulator
      end

## With a Symbol, With an Initial Accumulator

There are two differences between invoking `reduce` with an argument _and_ a symbol versus with only a symbol:

1.  The interpreter initially assigns the accumulator to the given argument.
2.  The interpreter iterates through the _entire_ receiver, i.e., it does not skip the first element.

    [1, 2, 3].reduce(10, :+) #=> 16
    [1, 2, 3].reduce(5, :*) #=> 30

## With a Block, Without an Argument

These two invocations of `reduce` are functionally equivalent:

    [1, 2, 3].reduce(:+)
    [1, 2, 3].reduce {|acc, el| acc + el}

The second invocation is more explicit. The interpreter stores the first element of the array in the `acc` argument and adds every subsequent element in succession. After each iteration, the interpreter _reassigns_ `acc` _to the return value of the block_. It returns `acc` when no elements remain.

Invoking `reduce` with a block gives greater control over how to reduce the receiver. One isn't limited to binary methods or operations:

    def sum_first_and_odds(arr)
      arr.reduce do |acc, el|
        if el.odd?
          acc + el
        else
          # this else statement is necessary because otherwise the return value of
          # the block would be nil if the element is even. Thus the interpreter
          # would reassign acc to nil.
          acc
        end
      end
    end

    sum_first_and_odds([1, 2, 4, 5]) #=> 6

Nor does one need to combine elements. The accumulator is simply a variable available throughout the iteration that's reassigned after each iteration. In Step 1's sixth practice assessment, we wrote a method that determined the longest word in a string. Here's the original solution and one using `reduce`:

    # OLD SOLUTION
    def longest_word(str)
      words = str.split
      longest_word = ""

      words.each do |word|
        if word.length > longest_word.length
          longest_word = word
        end
      end

      longest_word
    end

    # REDUCED EXCELLENCE
    def longest_word(str)
      str.split.reduce do |longest, word|
        if word.length > longest.length
          word
        else
          longest
        end
      end
    end

This approach is limited by the need to use the first element in the array as the accumulator. What about when we want to use a counter or a result array? The first element wouldn't suffice in most cases. Enter the final way to invoke `reduce`.

## With a Block, With an Initial Accumulator

Let's rewrite three methods from Prep Step 1 using this latest variation of `reduce`. We'll employ three different initial accumulator arguments: `0` as a counter, an empty string, and an empty array.

In the first practice assessment, we asked you to define a method (`e_words(str)`) that accepts a string as an argument. This method returns the number of words in the string that end in the letter "e" (e.g., `e_words("Let be be finale of seem") => 3`). Here's the solution we provided:

    def e_words(str)
      words = str.split
      count = 0

      words.each do |word|
        count += 1 if word[-1] == "e"
      end

      count
    end

Take a moment to study an implementation using `reduce`:

    def e_words(str)
      str.split.reduce(0) do |count, word|
        if word[-1] == "e"
          count + 1
        else
          count # return existing count from block so count isn't reassigned to nil
        end
      end
    end

Using `reduce` with an initial accumulator reduces defining a counter variable and iterating through a collection to a single method invocation.

In the fifth practice assessment, we asked you to define a method, `boolean_to_binary`, which accepts an array of booleans as an argument. The method should convert the array into a string of 1's (for `true` values) and 0's (for `false` values) and return the result. Here's our solution as well as an implementation using `reduce` with an empty string as the initial accumulator:

    # OLD SOLUTION
    def boolean_to_binary(arr)
      binary = ""

      arr.each do |boolean|
        if boolean
          binary += "1"
        else
          binary += "0"
        end
      end

      binary
    end

    # REDUCED EXCELLENCE
    def boolean_to_binary(arr)
      arr.reduce("") do |str, boolean|
        if boolean
          str + "1"
        else
          str + "0"
        end
      end
    end

Think about how you might implement `factors(num)` using `reduce`. We wrote this method in the exercises for Control Flow. What value would serve as an initial accumulator, i.e., what should be available throughout the iteration? Try to code an implementation using `reduce` before looking at the solution:

    # OLD SOLUTION
    def factors(num)
      factors = []
      (1..num).each do |i|
        if num % i == 0
          factors << i
        end
      end
      factors
    end

    # REDUCED EXCELLENCE
    def factors(num)
      (1..num).reduce([]) do |factors, i|
        if num % i == 0
          factors << i
        else
          factors
        end
      end
    end

`reduce` is complicated, but it's one of the most powerful built-in methods in Ruby. Whenever you find yourself setting a variable you reference throughout an iteration, consider using `reduce` to simplify your code.

**Note:** The `reduce` method is synonymous with `inject`. `reduce` seems more descriptive, but you'll often see `inject` out in the Ruby wilds.