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