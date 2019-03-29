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

# Counter Hashes

An alternative syntax for a declaring a hash is `Hash.new`. The `new` method takes an optional argument: the default value of each key. When one tries to access a nonexistent key in a hash with a default value, the return value is that default value. Accessing a nonexistent key, however, does not create a new key-value pair. If one doesn't set a default value, accessing a nonexistent key returns `nil`.

    # without a default value
    dog_breeds = {"corgi"=>"short and sweet", "labrador"=>"labradorable"}
    dog_breeds["Australian cattle dog"] #=> nil

    # with a default value
    default_cuties = Hash.new("cutie")
    default_cuties["vizsla"] #=> "cutie"

    # accessing a nonexistent key doesn't alter the hash
    default_cuties #=> {}

Setting a default value of `0` is helpful for creating a counter hash, one that counts the number of occurrences of particular elements or types of elements within a collection. Typically each key is an element in the collection and each value is the number of occurrences of that key. Counter hashes allow one to elegantly solve many complex problems. Here's a counter hash in action:

    word_counts = Hash.new(0)

    # Punctuation has been removed to simplify extracting words
    walrus_speculations = "If seven maids with seven mops
    Swept it for half a year
    Do you suppose the Walrus said
    That they could get it clear
    I doubt it said the Carpenter
    And shed a bitter tear"
    walrus_speculations.split.each do |word|
      # increment value at that key (which is by default 0)
      # this alters the hash because we use the assignment operator (=)
      word_counts[word.downcase] += 1
    end

    word_counts #=> {"if"=>1, "seven"=>2, "maids"=>1, "with"=>1, "mops"=>1, "swept"=>1,
                #    "it"=>3, "for"=>1, "half"=>1, "a"=>2, "year"=>1, "do"=>1, "you"=>1,
                #    "suppose"=>1, "the"=>2, "walrus"=>1, "said"=>2, "that"=>1, "they"=>1,
                #    "could"=>1, "get"=>1, "clear"=>1, "i"=>1, "doubt"=>1, "carpenter"=>1,
                #    "and"=>1, "shed"=>1, "bitter"=>1, "tear"=>1}

Counter hashes are especially powerful in combination with `sort_by`: one can easily sort by the frequency of elements (i.e., the counter hash's values). The method below returns the third-most common element in an array. Imagine how much more difficult this method would be to implement without a counter hash.

    def third_most_common(arr)
      counts = Hash.new(0)

      arr.each do |el|
        counts[el] += 1
      end

      frequency_array = counts.sort_by {|k,v| v}

      # remember sort_by returns an array of [k, v] arrays
      # return the first element (the key) from the third array from the end
      frequency_array[-3].first
    end

    third_most_common([1, 2, 2, 3, 3, 3, 4, 4, 4, 4]) #=> 2

<br />