# Strings

Our original definition of a string was "A sequence of characters enclosed in quotation marks; Ruby's representation of text." Strings and arrays have much in common. Both are sequences that can be accessed and manipulated, often using the same methods. It's useful to think of strings as arrays of one-character strings, though `["c", "a", "t"]` and `"cat"` are not technically equivalent.

## Access, Assignment, and Concatenation

[Video](https://player.vimeo.com/video/277204507?rel=0)

Like arrays, strings use the bracket method for access. Each character corresponds to an index. Strings are zero-indexed like arrays. The only difference between array access and string access is that the `first` and `last` methods are unavailable to strings.

    words_to_the_third = "Words, words, words."
    words_to_the_third[0] #=> "W"
    words_to_the_third[-1] #=> "."
    words_to_the_third[2..10] #=> "rds, word"
    words_to_the_third[2..-1] #=> "rds, words, words."
    words_to_the_third[2..(words_to_the_third.length - 1)] #=> "rds, words, words."
    words_to_the_third[99] #=> nil

String assignment uses the same syntax as array assignment.

    scary_word = "palindromic"
    scary_word[0] = "a"
    scary_word #=> "aalindromic"
    scary_word[1..6] = "ibohph"
    scary_word[-3..-1] = "bia"
    scary_word #=> "aibohphobia"

As you'd probably guess, one concatenates strings similarly to arrays. The only difference is that the shovel operator (`<<`) also concatenates strings. While shoveling one array into another causes nestedness, strings cannot be nested; `<<` therefore merely concatenates strings.

    # concatenation with + does not modify the original array
    broken_half_one = "we belong"
    broken_half_two = "together"
    broken_half_one + " " + broken_half_two #=> "we belong together"
    broken_half_one #=> "we belong"

    # use syntactic sugar to modify broken_half_one
    broken_half_one += " "
    broken_half_one += broken_half_two
    broken_half_one #=> "we belong together"

    # concatenation with concat or << modifies the original array
    broken_half_one = "we belong"
    broken_half_two = "together"
    broken_half_one.concat(" ")
    broken_half_one #=> "we belong "
    broken_half_one << "together"
    broken_half_one #=> "we belong together"

Here we can look at how Ruby is interacting a little behind the scenes with some of the code that we're getting more familiar writing.

[Video](https://player.vimeo.com/video/277204544?rel=0)

Another look at how the code we're writing is going to change or persist our data depending on the operations we use.

[Video](https://player.vimeo.com/video/277204576?rel=0)