# Iterators and Enumerables

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