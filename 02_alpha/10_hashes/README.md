# Hashes

[Video](https://player.vimeo.com/video/198425170?rel=0&amp;autoplay=1)

A **hash** is a collection of key-value pairs with unique keys. One can also imagine arrays as a collection of key-value pairs, where the keys are the indices. One accesses a value in an array _via its key_, i.e., with its index. Consider `["a", "b", "c", "d"]`:

<table>

<thead>

<tr>

<th>Key</th>

<th>Value</th>

</tr>

</thead>

<tbody>

<tr>

<td>0</td>

<td>"a"</td>

</tr>

<tr>

<td>1</td>

<td>"b"</td>

</tr>

<tr>

<td>2</td>

<td>"c"</td>

</tr>

<tr>

<td>3</td>

<td>"d"</td>

</tr>

</tbody>

</table>

## Declaration, Access, Assignment

One declares a hash with curly braces. `{}` is an empty hash, i.e., a hash of length zero. One can store key-value pairs in a hash by separating them with commas and enclosing them in curly braces. Each key points to its value via the **hash rocket** (`=>`). This hash is equivalent to `["a", "b", "c", "d"]`:

    # Declaration
    simple_hash = {0=>"a", 1=>"b", 2=>"c", 3=>"d"}

    # Access
    simple_hash[0] #=> "a"

Accessing values in a hash using keys has the same bracket syntax as accessing values in an array using indices. Accessing a nonexistent key returns `nil`:

    simple_hash = {0=>"a", 1=>"b", 2=>"c", 3=>"d"}
    simple_hash[:mr_monkey_pants] #=> nil

The syntax for hash assignment is also the same as array assignment:

    simple_hash = {0=>"a", 1=>"b", 2=>"c", 3=>"d"}

    # Assignment
    simple_hash[0] = "z"

    simple_hash #=> {0=>"z", 1=>"b", 2=>"c", 3=>"d"}

One adds new key-value pairs to a hash by assigning a value to a hereto nonexistent key:

    increasingly_less_simple_hash = {0=>"z", 1=>"b", 2=>"c", 3=>"d"}
    increasingly_less_simple_hash[5] = "w"
    increasingly_less_simple_hash #=> {0=>"z", 1=>"b", 2=>"c", 3=>"d", 5=>"w"}

So far you may be wondering what all the hubbub is about. We can do all these operations using array indices! Much of the magic of hashes derives from the fact that the keys are arbitrary and may be of any data type. The only constraint is that all keys must be unique. If two `5` keys pointed to different values, the Ruby interpreter wouldn't know which value to access. In practice, the interpreter overwrites the earlier key-value pair when one provides another key-value pair with an equivalent key.

    # The formatting is purely for legibility.
    nerdy_hash = {
      "fibonacci_numbers" => [0, 1, 1, 2, 3, 5],
      :pre_socratics => ["Thales", "Xenophanes", "Diogenes", "Heraclitus", "Pythagoras"],
      true => "Ruby first appeared in 1995."
    }

One can use an alternative syntax for declaring key-value pairs if the keys are symbols. Simply append a colon to the end of the symbol and remove its initial colon. No hash rocket needed.

    nerdy_take_two = {
      fibonacci_numbers: [0, 1, 1, 2, 3, 5],
      pre_socratics: ["Thales", "Xenophanes", "Diogenes", "Heraclitus", "Pythagoras"],
      true: "Ruby first appeared in 1995."
    }

    nerdy_take_two[:true] #=> "Ruby first appeared in 1995."


<br />

# Hash Methods

The `include?` method returns a boolean indicating whether its argument is a key in the hash. `has_key?` and `key?` are synonyms of `include?`. The `has_value?` method returns a boolean indicating whether its argument is a _value_ in the hash. `value?` is a synonym of `has_value?`.

    a_hash_is_like_a_dictionary = {
      "Wittgenstein"=> "The power of language to make everything look the same
        which appears in its crassest form in the dictionary",
      Nabokov: "The reader should have a dictionary."
    }

    a_hash_is_like_a_dictionary.include?("Wittgenstein") #=> true
    a_hash_is_like_a_dictionary.has_value?("Arthur the Aardvark") #=> false

The `keys` method returns an array of all the keys in its receiver. The `values` method returns an array of all the values. The `length` method returns the number of key-value pairs.

    shorter_example_thankfully = {
      a: 0,
      b: 1,
      c: 2
    }

    shorter_example_thankfully.keys #=> [:a, :b, :c]
    shorter_example_thankfully.values #=> [0, 1, 2]
    shorter_example_thankfully.length #=> 3

The `to_a` method type converts its receiver hash into a nested array of <a href="" target="_blank">_key_, _value_</a> arrays. Conversely, one can type convert a nested array of two-element arrays to a hash with the `to_h` method.

    hbo_shows_ranking = {
      "The Wire" => 1,
      "True Detective Season 1" => 2,
      "Westworld" => 3
    }

    hbo_shows_ranking.to_a #=> [["The Wire", 1], ["True Detective Season 1", 2], ["Westworld", 3]]

    animated_ranking = [["South Park", 1], ["Rick and Morty", 2], ["Archer", 3]]
    animated_ranking.to_h #=> {"South Park"=>1, "Rick and Morty"=>2, "Archer"=>3}

<br />

# Hash Iterators and Enumerables

Hashes have a different set of iterators than arrays. They share `each`, but hashes also have the methods `each_key` and `each_value`. Hashes don't have an `each_index` method because they don't have indices! Because hashes store key-value pairs rather than individual elements, the syntax for iterating through them using `each` differs: the given block takes _two_ arguments, a key and a value.

    translations = {
      Latin: "suum cuique",
      English: "to each his own",
      Spanish: "A cada cual lo suyo"
    }

    # each takes a block that takes two arguments: a key and value
    translations.each {|k, v| puts "#{k}: #{v}"}  

    # each_key and each_value take a block that takes one argument: a key or a value
    translations.each_key {|k| puts k}
    translations.each_value {|v| puts v}

Hashes have access to all the enumerables you've hopefully grown to love except for `each_with_index` and `with_index`. Like `each`, the given block takes two arguments--a key and a value--when the receiver is a hash.

    silly_yllis = {
      "stressed"=>"desserts",
      "redrum"=>"murder",
      "god"=>"dog",
      "erehwon"=>"nowhere"
    }

    silly_yllis.all? {|k, v| k == v.reverse} #=> true
    silly_yllis.count {|k, v| k != v.reverse} #=> 0

    # map still returns an array
    silly_yllis.map {|k, v| k + v} #=> ["stresseddesserts", "redrummurder", "goddog", "erehwonnowhere"]

    # select returns a hash
    silly_yllis.select {|k, v| k.length < 4} #=> {"god" => "dog"}

With a hash as the receiver, `sort_by` returns a nested array of <a href="" target="_blank">_key_, _value_</a> arrays in the order specified by its block:

      to_be_sorted_by_key = {b: 5, a: 10, c: 20}
      to_be_sorted_by_key.sort_by {|k, v| k} #=> [[:a, 10], [:b, 5], [:c, 20]]

<br />