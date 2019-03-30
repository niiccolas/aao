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