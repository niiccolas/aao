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