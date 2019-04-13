# Hash Cheat Sheet

Here is a quick reference for the methods and operations we learned in the previous lectures!

## Access

```ruby
hash = { "name" => "App Academy", "color" => "red" }

p hash["color"]  # prints "red"
p hash["age"]    # prints nil

k = "color"
p hash[k]        # prints "red"

hash["age"] = 5
p hash           # prints {"name"=>"App Academy", "color"=>"red", "age"=>5}
```

## Checking Existence

```ruby
hash = { "name" => "App Academy", "color" => "red" }

p hash.has_key?("name")             # prints true
p hash.has_key?("age")              # prints false
p hash.has_key?("red")              # prints false

p hash.has_value?("App Academy")    # prints true
p hash.has_value?(20)               # prints false
p hash.has_value?("color")          # prints false
```

## Hash Enumerable Methods

```ruby
hash = { "name" => "App Academy", "color" => "red" }

hash.each { |key, val| p key + ', ' + val} # prints
# "name, App Academy"
# "color, red"

hash.each_key { |key| p key } # prints
# "name"
# "color"

hash.each_value { |val| p val } # prints
# "App Academy"
# "red"
```

## Hash.new

```ruby
  plain_hash = { }
  plain_hash["city"] = "SF"
  p plain_hash["city"]    # prints "SF"
  p plain_hash["country"] # prints nil

  hash_with_default = Hash.new("???")
  hash_with_default["city"] = "NYC"
  p hash_with_default["city"]    # prints "NYC"
  p hash_with_default["country"] # prints "???"
```