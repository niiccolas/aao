# Introduction to Arrays
A data structure is a format for organizing and storing data. Data structures allow us to represent, access, and manipulate a collection of data. A classic example of a data structure is the array, an ordered, zero-indexed collection of objects.

## Declaration
In Ruby we declare an array with square brackets. [] is an empty array, i.e., an array of length zero. We can store items in an array by separating them with commas and enclosing them in square brackets. Any object or combination of objects (including other arrays) can be stored in an array.
```
empty_array = []
int_array = [1,2,3]
str_array = ["str1", "str2", ""]
mixed_array = [1, false, :sym, "str", nil]
nested_array = [[]]
```
Although Ruby permits heterogeneous arrays, it's generally preferable to maintain a single data type throughout the array, ensuring predictability when accessing or manipulating the array. An array that includes another array is called a nested or two-dimensional array. Nested arrays are considered "two-dimensional" because their contents can be arranged as a two-dimensional grid like so:
```
# This is a simple nested array
array1 = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 1], [2, 3, 4, 5, 6], [7, 8, 9, 1, 2]]

# This is how we would visualize it in two-dimensions
array2 = [
  [1, 2, 3, 4, 5],
  [6, 7, 8, 9, 1],
  [2, 3, 4, 5, 6],
  [7, 8, 9, 1, 2]
]
```
Don't worry too much about this. Focus on one-dimensional arrays for now, then add more dimensions later as you get comfortable.

<br />


# Array Access

[Video](https://player.vimeo.com/video/182448670?rel=0&amp;autoplay=1)

Each element in an array is assigned an index which corresponds to its position in that array. Often we will want to access an element at a specific index in an array. To do this, we can use the `[]` method, which uses a special syntax. We refer to this useful tool as the 'bracket' method. By calling this method on any array and putting an index number inside the brackets, we will get back whatever element is in that array at that index.
```
got_characters = ["Robb", "Sansa", "Arya", "Bran", "Rickon"]
got_characters[0]  # => "Robb" # got_characters.[](0) is equivalent but uglier
got_characters[3]  # => "Bran"
got_characters[20] # => nil (nothing exists at this index)
```
Arrays are zero-indexed, i.e., the first element of the array is at the zeroth index. The second element of the array is at the first index.

We can also access array elements using negative indices. The last element of the array is at an index of -1, the penultimate is at -2, etc.
```
got_characters = ["Robb", "Sansa", "Arya", "Bran", "Rickon"]
last = got_characters[-1] #=> "Rickon"
third_to_last = got_characters[-3] #=> "Arya"

last + " " + third_to_last #=> "Rickon Arya"
```
We can access multiple elements in an array by using ranges instead of single indices. Doing so returns an array with just those elements at the specified range of indices.
```
got_characters = ["Robb", "Sansa", "Arya", "Bran", "Rickon"]
got_characters[0..2] #=> ["Robb", "Sansa", "Arya"]
got_characters[0...-1] #=> ["Robb", "Sansa", "Arya", "Bran"]
```
`0..2` is a range object, another data structure. The two dots indicate that the range is inclusive, i.e., the range comprises all integers from `0` to `2`, including `2`. Three dots indicate an exclusive range: `0...11` is equivalent to `0..10`. One can also declare a range of characters (e.g., `"a".."c"`, `"A"..."D"`). One can type convert a range to an array using the `to_a` method:
```
(0..2).to_a #=> [0,1,2]
("A"..."D").to_a #=> ["A", "B", "C"]
```
Although the range `0...-1` in `got_characters[0...-1]` is technically empty, when using a range in array access, -1 is equivalent to the array's length minus one.
```
got_characters = ["Robb", "Sansa", "Arya", "Bran", "Rickon"]
got_characters[0...-1] == got_characters[0...(got_characters.length - 1)] #=> true
```
Ruby provides idiomatic methods for accessing the first and last elements of arrays:
```
got_characters = ["Robb", "Sansa", "Arya", "Bran", "Rickon"]
got_characters.first #=> "Robb"
got_characters.last #=> "Rickon"
```

<br />

# Array Assignment
Once you've accessed elements in an array, you can reassign them to new values. The assignment of array elements uses the same syntax as variable assignment. We can use the `[]` method to access a specific index in an array, and then use `=` to assign that index to a new value just like we do with any other variable.

For example, if you wanted to be totally blasphemous, you can make your array of Game of Thrones characters include characters from another television show:
```
blasphemous_characters = ["Robb", "Sansa", "Arya", "Bran", "Rickon"]
blasphemous_characters[0] = "Rick"
blasphemous_characters #=> ["Rick", "Sansa", "Arya", "Bran", "Rickon"]
blasphemous_characters[3..-1] = "Morty", "Snuffles" # this is called multiple assignment
blasphemous_characters #=> ["Rick", "Sansa", "Arya", "Morty", "Snuffles"]
```
You can even assign elements to valueless array indices:
```
blasphemous_characters = ["Robb", "Sansa", "Arya", "Bran", "Rickon"]
blasphemous_characters[blasphemous_characters.length] = "Morty"
blasphemous_characters #=> ["Robb", "Sansa", "Arya", "Bran", "Rickon", "Morty"]
blasphemous_characters[8] = "Rick"

# The Ruby interpreter fills in the empty indices with nil
blasphemous_characters #=> ["Robb", "Sansa", "Arya", "Bran", "Rickon", "Morty", nil, nil, "Rick"]
```
## Multiple Assignment and Array Destructuring
Let's briefly examine multiple assignment. In `blasphemous_characters[3..-1]`, we access a two-element subarray. We simultaneously reassign both elements by providing two comma-separated values. The accessed elements and their new values exactly correspond. We can also perform multiple assignment with variables rather than array elements:
```
#mutliple assignment of array elements
# note that accessed array elements behave as variables
elementary_array = [1, 2, 3]
elementary_array[0..1] = "a", "b"
elementary_array #=> ["a", "b", 3]

#multiple assignment of variables
a, b = 1, 2
a #=> 1
b #=> 2
```
The converse of multiple assignment is a sophisticated technique known as array destructuring, where one assigns multiple variables to multiple array elements (as opposed to assigning multiple array elements to multiple values). The syntax for array destructuring is similar to multiple assignment.
```
a, b = [1, 2]
a #=> 1
b #=> 2

# The first n elements in the array are assigned,
# where n is the number of variables
a, b = [1, 2, 3, 4]
a #=> 1
b #=> 2
```

<br />

# push, pop, unshift, and shift

[Video](https://player.vimeo.com/video/182440643?rel=0&amp;autoplay=1)

Four crucial array methods allow one to add and remove elements from the front or back of an array. `push` adds an element to the end of an array, while `pop` removes an element from the end of the array. `push` takes an argument (the element to be added) and returns the modified array. `pop` takes no argument and returns the element removed. Both methods modify the original array.
```
potpourri = [false, "Snuffles", nil, :rick, 3]
potpourri.push([]) #=> [false, "Snuffles", nil, :rick, 3, []]
potpourri #=> [false, "Snuffles", nil, :rick, 3, []] (push modified potpourri)
tail = potpourri.pop #=> []
potpourri #=> [false, "Snuffles", nil, :rick, 3] (pop modified potpourri)
tail #=> []
```
The shovel operator (`<<`) is functionally equivalent to `push`, but it allows for the simpler syntax typical of operators:
```
potpourri = [false, "Snuffles", nil, :rick, 3]
potpourri << ["Jerry", :krombopulos_michael] #=> [false, "Snuffles", nil, :rick, 3, ["Jerry", :krombopulos_michael]]
```
The analogues of `push` and `pop` for the front of the array rather than the end are `unshift` and `shift`. Both modify the original array.
```
potpourri = [false, "Snuffles", nil, :rick, 3]
potpourri.unshift([]) #=> [[], false, "Snuffles", nil, :rick, 3]
potpourri #=> [[], false, "Snuffles", nil, :rick, 3] (unshift modifies potpourri)
potpourri.shift #=> []
potpourri #=> [false, "Snuffles", nil, :rick, 3] (shift modified potpourri)
```

<br />

# Concatenation
Ruby provides two ways to concatenate arrays, i.e., to join them together without nesting. The `concat` method does what its name suggests. Note that it modifies the original array.
```
potpourri = [false, "Snuffles", nil]
potpourri.concat([:rick, 3]) #=> [false, "Snuffles", nil, :rick, 3]

# concat modifies the original array
potpourri #=> [false, "Snuffles", nil, :rick, 3]

# using concat with an empty array is pointless
potpourri.concat([]) #=> [false, "Snuffles", nil, :rick, 3]
```
The second method for concatenation is the addition operator `(+)`. The addition operator, however, does not modify the arrays on its left or right; instead, it returns a new array containing the values of both arrays. One can use syntactic sugar to reassign the variable for the left array to its concatenated value.
```
potpourri = [false, "Snuffles", nil]
potpourri + [:rick, 3] #=> [false, "Snuffles", nil, :rick, 3]

# + does not modify the array
potpourri #=> [false, "Snuffles", nil]

#syntactic-sugar reassignment
potpourri += [:rick, 3]
potpourri #=> [false, "Snuffles", nil, :rick, 3]
```

<br />

# Join
The `join` method type converts an array to a string. As its name suggests, it joins every element in the array, each of which is implicitly converted to a string. `join` takes an optional argument: the separator. The separator is a string that the method splices between every element in the joined array. By default, the separator is `''`, an empty string, effectively joining the elements together with nothing between them. The `join` method does not modify the original array.
```
[1, 2, nil, 3].join #=> "123"
[1, 2, nil, 3].join(" ") #=> "1 2  3" <-note the extra space to accommodate nil

ex = [1, 2, 3]
ex.join(" joint ") #=> "1 joint 2 joint 3"

# ex is not modified
ex #=> [1, 2, 3]
```

<br />

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
