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