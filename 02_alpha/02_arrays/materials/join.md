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