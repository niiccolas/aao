# Blocks

## Goals

*   Understand the purpose of blocks
*   Know how to define a block, especially one that takes arguments.
*   Understand why not to `return` from inside a block.
*   Know how and why to pass a symbol into a method that takes a block.

## Blocks! Blocks! Blocks!

Blocks, more than anything, are what make Ruby unique. You can think of blocks as chunks of code that get passed into methods. Methods then **call** the block to customize their own behavior.

For instance, take `Enumerable#map`:

    [1, 2, 3].map { |num| num + 1 } # => [2, 3, 4]

`map` applies a block to each element of the array. What it does with each element depends on the block. For instance, instead of adding one to each element, we could square them:

    [1, 2, 3].map { |num| num * num } # => [1, 4, 9]

Fundamentally, methods often take blocks to allow the user to customize what the method will do.

## Block syntax

Blocks are either wrapped in curly braces, or with a "do" and "end". We could write the previous example as:

    [1, 2, 3].map do |num|
      num * num
    end # => [1, 4, 9]

Use braces for single-line blocks. _Always use do-end for longer blocks_.

Blocks are passed to a method, but they do not appear in the list of arguments. They come after the closing parentheses, if there are any:

    3.times { puts "Hey, friend!" } # don't need parens when there are no args
    3.times() { puts "Hey, friend!" } # block is given outside parens, if they are used

Blocks may take arguments, just like methods do. The argument names are wrapped in `|` (_pipes_).

    [1, 2, 3].map { |num| num * num }

Here `map` is going to call the block repeatedly; it will pass in each of the elements. Each time, the element (1, 2, or 3) will be _bound_ to the `num` argument declared between the pipes.

## Avoid return inside a block

Blocks implicitly return values like Ruby methods; the last value is implicitly returned from the block.

This is how `Enumerable#map` works: it calls the block on each element, adding the returned value to a new collection:

    [1, 2, 3].map do |num| 
      num + 1   # num + 1 will be returned
    end
    # => [2, 3, 4]

Do **not** explicitly `return` from a block:

    [1, 2, 3].map do |num| 
      return num + 1   # surprise!
    end

This will not merely return from the block, **it will return from the context where the block was defined.** Huh? What does that mean?

Take a look at the example below:

    # example 1
    def test1
      [1, 2, 3].map do |num|
        num + 1
      end

      puts "All done!"
    end

    # example 2
    def test2
      [1, 2, 3].map do |num|
        # this is going to return immediately *from test2*
        # will not wait for printing end time, or "Never called!"
        return num + 1
      end

      puts "Never called!"
    end

We might have thought we could treat the block as its own method. Under this theory, return would just return from the block.

This is not what a block does, though: it will return from the context where it was first defined. In example two, this results in the unexpected behavior where the `return` statement returns from _the entire test2 method_ instead of the block.

For experienced programmers learning Ruby, this can be surprising behavior. In other languages (like Lisp and JavaScript), return would only return from the block. Ruby does have a way to do this (lambdas), but they are not as commonly used as blocks.

As you grow more experienced, you may learn to recognize times where it might be convenient to return from a block and take advantage of this feature. In general, however, don't do this, since it can be somewhat unpredictable. Even if the code makes sense to you, this can be confusing in a team setting where many people may be expected to reference what you've written.

## Symbols and blocks

It is very, very common to have blocks that take an argument and call a single method:

    ["a", "b", "c"].map do |str| 
      str.upcase  # upcase all strings
    end 

    [1, 2, 5].select do |num| 
      num.odd? 
    end

In this case, Ruby gives us a shortcut:

    ["a", "b", "c"].map(&:upcase)
    [1, 2, 5].select(&:odd?)

What's happening here? Using the `&` symbol calls [`#to_proc`](http://ruby-doc.org/core-2.1.2/Symbol.html#method-i-to_proc) on the item following the ampersand. We will get more into Procs in the next reading, but essentially, it is taking the method and "wrapping" it in an object so that we can pass it in as an argument. Normally, methods cannot be passed into other methods like this, so "wrapping" it in this way is necessary. When `#to_proc` is called on a symbol, we get back a `Proc` object that just calls a method with the same name as the symbol on its argument.

Proceed to the next reading to learn more about Procs and how they work.

# Procs

## Goals

*   Know how to write a method that takes a block.
*   Understand the difference between blocks and [procs](http://ruby-doc.org/core-2.1.2/Proc.html).
*   Know what `#to_proc` and `&` are used for.

## Writing a method that takes a block

Let's write a method, `maybe` that will call a block only if the argument passed in is true. It should work like this:

    maybe(true) { puts "Hello!" } # runs block, since passed true
    maybe(false) { puts "Goodbye!" } # doesn't run block

The problem with defining a method that takes a block is that we need a variable to represent the block in our code. However, blocks are methods, not variables, so they cannot be passed into another method in their current state.

The solution in this case is to use what is called a [`Proc`](http://ruby-doc.org/core-2.1.2/Proc.html). A Proc is an object that _contains_ a block as one of its properties, essentially serving as a "wrapper" for the block, and since objects CAN be passed to methods, this solves the problem of passing our block to the method.

Procs are defined in the argument list using a special notation:

    def maybe(flag, &prc)
      prc.call if flag
    end

Notice the `&prc` argument? The ampersand is a special symbol that signifies that `prc` should hold a `Proc`. If the user provides a block, as we did above for `maybe`, it gets turned into a `Proc` object, which is then stored in the `prc` variable; if no block is provided, `prc` is set to `nil`. We need to mark the variable with a `&` because blocks are not passed like normal arguments; they don't appear inside the parens in the list of values to pass in.

`Proc#call` calls the block. Any arguments you pass to `call` will be passed on to the block.

What's the difference between a block and a `Proc`? A block is the Ruby code you write; it is not a real Ruby object. The `Proc` is an object that "wraps" your code so that it can be stored in a variable and passed to methods. `Proc#call` allows you to invoke the method whenever you want.

## Creating Procs

If you ever feel the need to, you can create a `Proc` object yourself:

    my_proc = Proc.new { "Hey, friend!" }
    my_proc.call # => "Hey, friend!"
    my_proc.call # calls it again

Again, any arguments you pass to `call` will be passed on to the block:

    my_new_proc = Proc.new { |name| puts "Hello #{name}" }
    my_new_proc.call("Zimmy") # prints "Hello Zimmy"

## Passing multiple Procs

The `&` way only allows you to pass a single block/proc to a method. If you want to pass multiple procs, you must pass them as normal arguments:

    def chain_blocks(start_val, proc1, proc2, &proc3)
      val1 = proc1.call(start_val)
      val2 = proc2.call(val1)
      val3 = proc3.call(val2)

      val3
    end

    proc_add_1 = Proc.new {|num| num + 1}
    proc_add_2 = Proc.new {|num| num + 2}

    chain_blocks(1, proc_add_1, proc_add_2) do |num|
      num + 3
    end

This passes in three procs; `proc_add_1`, `proc_add_2`, and then the third block after it has been procified. Note that the `&` is only used for the Proc that we pass in using block notation, as the other two blocks have already been wrapped.

### yield

Ruby has a special syntax which simplifies passing blocks. You may use the keyword `yield` to call the passed block without using a block variable. Let's rewrite `maybe`:

    def maybe(flag)
      yield if flag
    end

App Academy's preference is to list the block in the argument list (`&` style) and call the proc explicitly with `call`. This makes it clearer to a reader what arguments the method can take.

### prc.nil? and block_given?

If you want to check if a block is given, use `prc.nil?`. Similar to `yield`, you can use the special method `block_given?` if you don't want to list the block in the argument list.

## Passing procs to methods

Methods that take a block typically don't want to accept an explicit `Proc` object:

    add_one = Proc.new { |i| i + 1}
    [1, 2, 3].map(add_one) # wrong number of arguments (1 for 0)

Because the `&` symbol in the argument list tells Ruby to wrap the block argument in a `Proc`, we would essentially be wrapping the Proc twice. Ruby doesn't like this, so we have to make sure that Ruby understands we want to pass the proc in as the block/proc argument, not a normal argument. To do this, we use the `&` symbol again:

    add_one = Proc.new { |i| i + 1}
    [1, 2, 3].map(&add_one) # => [2, 3, 4]

This "unwraps" the `Proc` and turns it back into block form so that the method can wrap it in its own `Proc` object. Notice how this is kind of the flip-side of using `&` in the definition of a method.

As you might suspect, we get yelled at if we try to pass both a `Proc` this way in addition to a typical block:

    [1, 2, 3].map(&add_one) do
      "an actual block!" 
    end
    # SyntaxError: (eval):2: both block arg and actual block given

If this does not make sense, re-read this section a few more times. This concept typically takes a while to sink in.

## The different uses of `&`

You may have noticed that the `&` appears in many places in the examples above. The `&` can be tricky because it does several things:

*   Converts blocks to procs
*   Converts method names (passed as symbols) to procs
*   Converts procs to blocks

We have mostly seen the first two uses, but you should be aware of the third. For example, assume we have a method `my_sort!` that takes a block argument, like this:

    animals = ['cats', 'dog', 'badgers']
    animals.my_sort! do |animal1, animal2|
      animal1.length <=> animal2.length
    end
    p animals # => ['dog', 'cats', 'badgers']

We can easily define a non-bang version of this method like so:

    class Array
      def my_sort(&prc)
        self.dup.my_sort!(&prc)
      end
    end

The two uses of `&` in the above example do different things: the first one calls `#to_proc` on a block argument, creating a first-class proc object that we can refer to with `prc`. But `#my_sort!` expects a block argument, not a proc, so we can't simply pass it `prc`. Instead, when we call `#my_sort!`, we use `&` again, but this time `&` means _the opposite_ of what it meant in the previous line; now `&` is changing the proc back into a block, so we can pass it further down the chain without rewriting all of our code.

## Required video

*   Watch Peter's [Procs, Blocks and Lambdas](http://www.youtube.com/watch?v=VBC-G6hahWA).

## Resources

*   [Robert Sosinski on Blocks](http://www.reactive.io/tips/2008/12/21/understanding-ruby-blocks-procs-and-lambdas)
*   [Skorks on Procs and Lambdas](http://www.skorks.com/2010/05/ruby-procs-and-lambdas-and-the-difference-between-them/)

