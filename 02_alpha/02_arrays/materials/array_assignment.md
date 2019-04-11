# Assignment
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