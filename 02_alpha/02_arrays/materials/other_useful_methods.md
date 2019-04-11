# Other Useful Methods
Below are some array methods you may find useful for problem solving. These are some of the most common methods that you'll use as you start out working with arrays, but there are many more. You don't need to memorize all of these. Instead, become familiar with the official documentation for Ruby, which lists all the methods that can be called on arrays. Think of it as a dictionary for Ruby methods.

If you are familiar with the docs you'll find it easy to look up, discover, and reference methods as you need them.

### length

`length` returns the number of elements in the array.
```
[1, 2, 3, "a", "b", "c"].length #=> 6
```
### sort

`sort` sorts an array alphabetically or numerically. It requires that the array be comprised entirely of numbers or symbols or strings. Otherwise the interpreter won't know how to compare elements! Like many array methods, sort has a counterpart that modifies the original array: `sort!`. A bang (`!`) typically denotes methods that modify their receiver, so-called "dangerous" methods.

To review, `sort` will return a new array of the elements in the sorted order, while `sort!` will modify the original array that it is called on. Make sure you know the difference between a method and its 'bang' counterpart, and think about which one you actually want to use in a specific situation!
```
[3, 1, 2].sort #=> [1, 2, 3]
[:c, :a, :b].sort #=> [:a, :b, :c]
["c", "a", "b"].sort #=> ["a", "b", "c"]

in_the_danger_zone = [3, 1, 2]
in_the_danger_zone.sort!
in_the_danger_zone #=> [1, 2, 3]
```

### reverse
`reverse` reverses the order of an array. `reverse` has a dangerous version: `reverse!`.
```
[nil, false, "ranger danger"].reverse #=> ["ranger danger", false, nil]

the_dangerest_rangerest = [nil, false, "ranger danger"]
the_dangerest_rangerest.reverse!
the_dangerest_rangerest #=> ["ranger danger", false, nil]
```
### rotate
`rotate` rotates the array such that the element at the index its argument specifies becomes the first element of the array. If a negative argument is supplied, then the array rotates in the opposite direction. If no argument is supplied, the array rotates one position (i.e., the default argument is `1`). `rotate` has a dangerous version: `rotate!`.
```
["the", "rotation", "station"].rotate(2) #=> ["station", "the", "rotation"]
["the", "rotation", "station"].rotate(-1) #=> ["station", "the", "rotation"]
["the", "rotation", "station"].rotate #=> ["rotation", "station", "the"]
```
### uniq
`uniq` removes duplicate values from the array. `uniq` has a dangerous version: `uniq!`.
```
["blah", "blah", "blah", "he", "blahed"].uniq #=> ["blah", "he", "blahed"]
```
### flatten
`flatten` returns an array of one dimension, i.e., it flattens nested arrays. `flatten` has a dangerous version: `flatten!`.
```
["so", ["very"], [["meta"]]].flatten #=> ["so", "very", "meta"]
["so", "very", "meta"].flatten #=> ["so", "very", "meta"]
```
### compact
`compact` removes `nil`elements from the array. `compact` has a dangerous version: `compact!`.
```
["deliver us from", nil, "pues", nil].compact #=> ["deliver us from", "pues"]
```
### max and min
`max` returns the largest element of an array. `min` returns the smallest. Both `max` and `min` require that the array be comprised entirely of numbers or symbols or strings.
```
["a", "b", "c"].max #=> "c"
[1, 2, 3].min #=> 1
```
### count
`count` returns the number of elements equal to its argument. If no argument is given, it's synonymous with `length`.
```
[1, 2, 3, 2].count(2) #=> 2
[1, 2, 3, 3].count #=> 4
```
### empty?
`empty?` returns a boolean value indicating whether the array is of length zero.
```
[].empty? #=> true
[nil].empty? #=> false (technically)
```
### include?
`include?` returns a boolean value indicating whether its argument is included in the array.
```
["a", "b", "c"].include?("a") #=> true
["a", "b", "c"].include?(1) #=> false
```
### index
`index` returns the first index of the array at which the method's argument occurs. `index` returns `nil` if its argument is not in the array.
```
["a", "b", "c"].index("c") #=> 2
["a", "b", "c"].index(1) #=> nil
```
### delete
`delete` deletes its argument from the array and returns the deleted value. If the method's argument is not in the array, `delete` returns nil. `delete` modifies the original array.
```
array_in_inherent_danger = ["wheel", "wheel", "third wheel"]
array_in_inherent_danger.delete("third wheel") #=> "third wheel"
array_in_inherent_danger #=> ["wheel", "wheel"]

[1, 2, 3].delete("a") #=> nil
```
### delete_at
`delete_at` deletes the element at the index specified by the method's argument and returns that element. If the method's argument specifies an index out of range, `delete_at` returns `nil`. `delete_at` modifies the original array.
```
array_in_more_inherent_danger = ["wheel", "wheel", "third wheel"]
array_in_more_inherent_danger.delete_at(2) #=> "third wheel"
array_in_inherent_danger #=> ["wheel", "wheel"]

[1, 2, 3].delete_at(3) #=> nil
```
### take
`take` returns the first n elements of the array, where n is the method's argument. `take` does not modify the original array.
```
["a", "b", "c", "d", "e", "f"].take(1) #=> ["a"]
["a", "b", "c", "d", "e", "f"].take(5) #=> ["a", "b", "c", "d", "e"]
```
### drop
`drop` is the converse of `take`. It returns the remainder of the array after n elements have been taken, where n is the method's argument. `drop` does not modify the original array.
```
["a", "b", "c", "d", "e", "f"].drop(1) #=> ["b", "c", "d", "e", "f"]
["a", "b", "c", "d", "e", "f"].drop(5) #=> ["f"]
```
We also encourage you to reference and explore [Ruby's documentation for Enumerable methods](https://ruby-doc.org/core-2.3.1/Enumerable.html) -- these are some very useful methods that can also be called on arrays as well as some other Ruby objects that we'll discuss later.