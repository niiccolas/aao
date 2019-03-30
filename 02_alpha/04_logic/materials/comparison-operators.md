# Logic

We're ready to incorporate logic into our Ruby programs. We'll soon build programs that react dynamically to logical propositions. For now, we'll learn how to construct those propositions and examine the Ruby interpreter's evaluation of them.

## Comparison Operators

Ruby provides several operators that compare one object to another. Some are familiar from elementary mathematics. `>`, `<`, `>=`, `<=`, `==`, and `!=` mean what you'd expect: "greater than," "less than," "greater than or equal to," "less than or equal to", "equal to", and "not equal to." Note that `==`, not `=` checks for equality. Recall that `=` is the assignment operator. Comparison operators allow one to build expressions that the Ruby interpreter can evaluate as logical propositions. The expression generally evaluates to `true` if the proposition is valid and to `false` if it is invalid.

    3 > 2 #=> true
    3 >= 2 #=> true
    3 < 2 #=> false
    3 <= 2 #=> false
    3 == 2 #=> false
    3 != 2 #=> true

Ruby also permits string and symbol comparison. `"cat" < "dog"` returns `true` because "cat" precedes "dog" alphabetically (`:cat < :dog` is equivalent). One can compare different data types only when checking for equality. `"cat" < 4` throws an error. `"cat" != false` returns `true`. One can compare arrays only for equality, i.e., one array is not greater or less than another:

    [] == [] #=> true
    ["cat"] == ["cat"] #=> true
    ["cat"] >= ["cat"] # throws an error
    ["cat"][0] >= ["cat"][0] #=> true #(equivalent to "cat" >= "cat")

Every comparison operator returns a boolean value except for `<=>`, the **spaceship operator**. The spaceship operator functions somewhat how it looks. No, it won't take you to Mars, but it does do something almost as cool. The spaceship operator is a hybrid between "less than," "equal to," and "greater than." `a <=> b` returns `-1` if `a < b`, `0` if `a == b`, and `1` if `a > b`:

    2 <=> 3 #=> -1
    2 <=> 2 #=> 0
    3 <=> 2 #=> 1
