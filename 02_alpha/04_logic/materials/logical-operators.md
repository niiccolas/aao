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
