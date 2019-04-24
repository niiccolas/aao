# Enumerables

The Enumerable module (don't worry about what a module is for now!) contains a set of methods called **enumerables** that primarily traverse or sort collections (ranges, arrays, and hashes). We'll concern ourselves with only arrays until the next chapter, when we'll study hashes. You can already replicate the behavior of every enumerable, but these methods offer elegant solutions to common problems.

## all?, none?, any?

Here's how you might check whether every integer in an array is even using what you've learned:

    def all_even?(arr)
      arr.each { |int| return false if int.odd? }
      true
    end

The `all?` enumerable provides a more elegant and idiomatic implementation:

    def all_even?(arr)
      arr.all? { |int| int.even? }
    end

The `all?` method passes each element in its receiver to a given block. The method returns `true` if the block never returns a falsey value; otherwise it returns `false`.

The `all?` method has two cousins:

*   `none?` passes each element in its receiver to a given block. The method returns `true` if the block _never returns a truthy value_; otherwise it returns `false`.
*   `any?` passes each element in its receiver to a given block. The method returns `true` if the block _ever returns a truthy value_; otherwise it returns `false`.

    def none_even?(arr)
      # arr.all? { |int| int.odd? } is equivalent
      arr.none? { |int| int.even? }
    end

    def any_even?(arr)
      arr.any? { |int| int.even? }
    end

## map

Already tired of setting up result arrays and shoveling elements inside? What about having to awkwardly modify arrays with `each_index`? The `map` enumerable returns a new array that's the result of executing its given block once for each element in its receiver:

    simpleton = [1, 2, 3]
    simpleton.map { |int| int * 2 } #=> [2,4,6]
    simpleton #=> [1, 2, 3]

The `map` method has a dangerous version (`map!`) that modifies its receiver:

    about_to_be_slightly_less_simpleton = [1, 2, 3]
    about_to_be_slightly_less_simpleton.map! { |int| int ** 2 } #=> [1, 4, 9]
    about_to_be_slightly_less_simpleton #=> [1, 4, 9]

## count

Recall that the `count` method has two variations for arrays. It can take no argument, where it's synonymous with `length`, or it can take one argument, where it returns the number of elements equal to that argument. But `count` is more various still! When given a block, `count` returns the number of items that, when passed to that block, return a truthy value.

    [1, 2, 3, 4, 5].count #=> 5
    [1, 2, 3, 4, 5].count(2) #=> 1
    [1, 2, 3, 4, 5].count { |int| int.odd? } #=> 3

## select and reject

Like `map`, `select` returns a new collection, and like `all?`, `none?`, and `any?`, it evaluates each element in its receiver for truthiness. `select` returns a collection containing all the elements in its receiver for which the given block returns a truthy value. `reject` does the opposite: it returns a collection containing all the elements in its receiver for which the given block returns a _falsey_ value. Both `select` and `reject` have dangerous versions that modify their receivers (`select!` and `reject!`).

      array_of_terms = ["The blab of the pave", "tires of carts",
          "sluff of boot-soles", "talk of the promenaders",
          "The heavy omnibus", 'the driver with his interrogating thumb']

      array_of_terms.select { |t| t.length > 20 } #=> ["talk of the promenaders", "the driver with his interrogating thumb"]
      array_of_terms.reject { |t| t.length > 20 } #=> ["The blab of the pave", "tires of carts", "sluff of boot-soles",
                                                #    "The heavy omnibus"]

      # WELCOME TO THE DANGER ZONE
      array_of_terms.select! { |t| t.length > 20 } #=> ["talk of the promenaders", "the driver with his interrogating thumb"]
      array_of_terms #=> ["talk of the promenaders", "the driver with his interrogating thumb"]

## sort_by

The `sort_by` method sorts its receiver by the return values of its elements when they are passed to the given block, and it returns an array in that order. `sort_by` does not modify its receiver. Here's a method that uses `sort_by` to return an array of the words in its argument sorted by length.

    def words_by_length(str)
      words = str.split
      words.sort_by { |word| word.length }
    end

    poor_gregor = "As Gregor Samsa awoke one morning from uneasy dreams he found
                  himself transformed in his bed into a gigantic insect"

    words_by_length(poor_gregor) #=> ["a", "As", "he", "in", "his", "one", "bed",
                                 #    "into", "from", "found", "Samsa", "awoke",
                                 #    "insect", "Gregor", "dreams", "uneasy",
                                 #    "morning", "himself", "gigantic", "transformed"]

## each_with_index and with_index

`each_with_index` works as you'd expect: it calls the given block with two arguments--the item and the item's index--once for each item in the method's receiver. The syntax for passing two arguments for a block is unfamiliar but straightforward:

      three_lines = ["The", "mind", "has", "shown", "itself", "at", "times",
        "Too", "much", "the", "baked", "and", "labeled", "dough",
        "Divided", "by", "accepted", "multitudes."]

      three_lines.each_with_index do |word, idx| #the parameters are comma separated and in order
        if word = word.capitalize
          puts "The word at index #{idx} must be the start of a new line!"
        end
      end

If you'd prefer `map` to `each` (e.g., so you don't have to create a result array) or are iterating through a string, you can chain the `with_index` method to `map` or `each_char`.

    back_to_the_numbers_game = [1, 2, 3]
    back_to_the_numbers_game.map.with_index { |num, i| num - i } #=> [1, 1, 1]

    "abcd".each_char.with_index { |ch, i| puts "#{ch} is letter number #{i + 1} in the alphabet!" } #=> "abcd" (returns receiver)