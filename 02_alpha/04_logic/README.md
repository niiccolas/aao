# Logical Operators

Ruby has three logical operators, `&&` (AND), `||` (OR), and `!` (NOT). `&&` evaluates to `true` if both its operands are true. `||` evaluates to `true` if at least one operand is true. `!` returns `true` if its operand is `false` and `false` if its operand is `true`.

    true && true #=> true
    false && true #=> false
    false && false #=> false

    true || true #=> true
    true || false #=> true
    false || false #=> false

    !true #=> false
    !false #=> true

In `true || false`, the Ruby interpreter doesn't evaluate the code after `||` because it's superfluous. Since the first operand is `true`, the expression will be true regardless of the second operand. This behavior is an example of **short-circuit evaluation**, where the second operand of a logical operator is evaluated only if the first operand does not suffice to determine the value of the expression. Conversely, `false && true` is also an example of short-circuiting (the expression will be false regardless of the second operand).

`!`, sometimes known as _bang_, reverses the boolean value of its operand. Though `!` receives a single operand, that operand can be the result of an expression. `!(false || true)` returns `false`. `!false || true` would return `true` and would short-circuit.

`&&` and `||` also permit expressions as operands:

    3 < 5 && "cat" < "dog" #=> true
    5 < 3 || "cat" != "cat" #=> false

`and`, `or`, and `not` are near-synonyms of `&&`, `||`, and `!`. The sole difference is that they have lower precedence in the order of operations. For the purposes of this course, we will only be using `&&`, `||`, and `!` -- we strongly discourage (at least for now) ever using `and`, `or`, and `not`. Once you've finished the course and are out in the real world, you may find useful applications for these operators, but for now we will not be using them.


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

# Truthy and Falsey

Operating on booleans with logical operators is somewhat trivial. Much of the power of logical operators derives from the fact that every object in Ruby can be coerced to a boolean value (**truthiness** and **falseyness**), even if that object is not a boolean. Luckily what's truthy and what's falsey in Ruby is easy to remember. Only `false` and `nil` are falsey. All else is truthy.

`&&` and `||` assess operands according their truthiness or falseyness, but they return the actual value of one of those operands (not necessarily `true` or `false`), leading to some perhaps unexpected behavior. `&&` and `||` always return the last operand evaluated, which may or may not be the last operand in the expression. Because of short-circuiting, this value's truthiness or falseyness is always equivalent to the truthiness or falseyness of the entire expression.

    #no short-circuiting; "dog" is the last operand evaluated
    true && "dog" #=> "dog" (truthy)

    #short-circuiting; nil is the last operand evaluated
    nil && "dog" #=> nil (falsey)

    #no short-circuiting; false is the last operand evaluated
    nil || false #=> false (falsey)

    #short-circuiting; "cat" is the last operand evaluated
    "cat" || nil  #=> "cat" (truthy)

When in doubt of the truthiness or falseyness of a value, use `!!`. `!` returns `true` or `false` for a given operand--the opposite of that operand's truthiness or falseyness. `!!` therefore returns the boolean that correctly corresponds to the object's truthiness or falseyness (it returns the opposite of the opposite).

    # "cat" is truthy, therefore !"cat" is false, therefore !!"cat" is true
    !"cat" #=> false
    !!"cat" #=> true
