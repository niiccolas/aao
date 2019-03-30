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

