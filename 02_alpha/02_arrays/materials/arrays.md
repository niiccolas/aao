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