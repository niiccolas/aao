# Other Useful Methods

Strings share several other methods with arrays, including `length`, `reverse` (and `reverse!`), `empty?`, `include?`, and `index`:

    "How many characters do I have?".length #=> 30

    "stressed".reverse #=> "desserts"

    "".empty? #=> true
    "full".empty? #=> false

    "".include?("f") #=> false
    "full".include?("f") #=> true

    "full".index("u") #=> 1
    "full".index("ll") #=> 2

The `delete` and `count` methods behave slightly differently for strings. `delete` does not modify string receivers, and `count` must receive an argument when used with strings (`count` only counts occurrences of the substring and is _not_ synonymous with `length`). `delete` has a dangerous version just for strings: `delete!`. `delete` deletes any characters that appear in its argument.

    sad_string = "full of emptiness"
    sad_string.delete("e") #=> "full of mptinss"
    sad_string #=> "full of emptiness"

    sad_string.delete(" of emptiness") #=> "ull" ("f" appears in the argument)
    sad_string #=> "full of emptiness"

    sad_string.delete!("of emptiness") #=> "ull"
    sad_string #=> "ull"
    "f" + sad_string #=> "full" :)

    sad_string = "full of emptiness"
    sad_string.count("e") #=> 2