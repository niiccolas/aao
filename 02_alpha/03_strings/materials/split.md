# Split

The `split` method is the converse of `join`. While `join` combines the elements of an array into a string, `split` divides a string into an array. Like `join`, `split` takes an optional argument: the delimiter. The delimiter is a string along which `split` divides the receiver string. The delimiter itself is omitted from the returned array. By default, the delimiter is an empty space (`' '`). The `split` method does not modify the original string.

    proposition_one_point_two = "The world divides into facts."
    proposition_one_point_two.split #=> ["The", "world", "divides", "into", "facts."]
    proposition_one_point_two.split(' ') #=> ["The", "world", "divides", "into", "facts."]
    proposition_one_point_two.split('d') #=> ["The worl", " ", "ivi", "es into facts."]
    proposition_one_point_two.split('.') #=> ["The world divides into facts"]

    # the original string is not modified
    proposition_one_point_two #=> "The world divides into facts."

`split` has a cousin called `chars`. `chars` returns an array of characters in a string; it's equivalent to `split("")`. `chars` does not take an argument, nor does it modify the original string.

    "The world divides into facts.".chars #=> ["T", "h", "e", " ", "w", "o", "r", "l",
                                          #    "d", " ", "d", "i", "v", "i", "d", "e",
                                          #    "s", " ", "i", "n", "t", "o", " ", "f",
                                          #    "a", "c", "t", "s", "."]

