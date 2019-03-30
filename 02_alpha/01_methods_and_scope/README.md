# Method Deconstruction
`lcm` stands for Least Common Multiple. Every number has multiples. The `lcm` is the lowest multiple shared by two numbers. For example:

||1|2|3|4|5|6|
|--- |--- |--- |--- |--- |--- |--- |
|4|4|8|12|16|20|24|
|6|6|12|18|24|30|36|

4 and 6 have common multiples of 12 and 24 (and many higher numbers). The lcm of 4 and 6 is 12.

In Ruby, `lcm` is a method that is provided for you which can be called, or invoked, on any integer number. Let's look at an example where we call this method on the number `9`:
```
9.lcm(3)
```
In the example above, `9` is the receiver of the method `lcm`; it is the object upon which the method is called. By using a receiver in conjunction with the `.` syntax, we invoke or call the method. Method invocation is a call to the Ruby interpreter to execute the method.

`3` is the method's argument or input. The argument `3` is passed to the method `lcm`. Parentheses enclose arguments; commas separate multiple arguments. A method always expects a certain number of arguments. If a method is invoked with the wrong number of arguments, the Ruby interpreter will throw an error. `3.odd?(1)` yields this error message: `wrong number of arguments (given 1, expected 0)`.

When we run `9.lcm(3)`, the shell prints `=> 9`. The value following `=>` is the method's return value or output. `9.lcm(3)` evaluates to `9`. Altogether, we invoke the `lcm` method on the receiver `9` with the argument `3`, returning `9`.

<br />

# Method Definition
Methods are the "verbs" of Ruby. More specifically, a method is a group of expressions that returns a value. A method organizes code into a subroutine, a set of instructions that performs a specific operation. We can imagine lcm defined somewhere in Ruby's source code, perhaps as a sequence of expressions employing basic arithmetic methods, such as the modulo and multiplication operators.

Method definition assigns a subroutine to a name that can be invoked. Soon you'll be able to define your own version of `lcm`. But how does one define a method in Ruby? Let's define a method called `add_two_numbers` that, well, adds two numbers. Type the following into the shell:
```
def add_two_numbers(num_one, num_two)
  num_one + num_two
end
```
One defines a method by preceding the method's name with the keyword `def`. Method names conform to the same conventions and rules as variable names:

* They should be in snake case (this_is_snake_case).
* They cannot have special characters (&, ^, %, etc...`).
* They cannot be a reserved keyword.

`num_one` and `num_two` are the method's parameters. Parameters are variables declared upon method definition that represent the arguments passed in upon invocation. A method that's invoked with zero arguments would have zero parameters. Method definition ends in `end`. The code between the `def` statement and `end` is the method body. The method body is the subroutine the method definition encapsulates.

Defining a method does not invoke it, i.e., it does not instruct the Ruby interpreter to execute the code inside the method's body. One invokes custom methods by appending the arguments to the method's name. Try running this in the shell:
```
add_two_numbers(1, 2)
```
Note that the return value is `3`. The Ruby interpreter assigns `1` to `num_one` and `2` to `num_two`. The order of arguments is important. Arguments are assigned to parameters in matching order. The interpreter adds the arguments as the method's body instructs and returns the result.

<br />


# Returning from a Method
The result of the last line of a method is implicitly returned. One can explicitly return the line's result with the `return` keyword:
```
def add_two_numbers(num_one, num_two)
  return num_one + num_two
end
```
When the Ruby interpreter encounters an explicit return statement, it immediately returns the result of that statement. It would be pointless to execute subsequent code because the method's output has already been declared.

Try defining and invoking `whacky_returns` in the shell:
```
def whacky_returns(num_one, num_two)
  return num_one + num_two
  num_one = num_one + 1
  return num_one - num_two
end

whacky_returns(1,2)
```

`whacky_returns(1,2)` returns `3`. Because `whacky_returns` explicitly returns `num_one + num_two` in the first line, it is functionally equivalent to `add_two_numbers`. The two lines following return `num_one + num_two` are unreachable code, code that can never be executed.

## Return Versus Puts
Why use `return` instead of `puts`? The shell prints the expression whether we return or "puts" it. Let's try defining and invoking `add_two_numbers` with `puts`:
```
def add_two_numbers(num_one, num_two)
  puts num_one + num_two
end

add_two_numbers(1,2)
```
Take a moment to consider what the shell prints:
```
3
=> nil
```
Although the shell prints `3` as expected, the return value of `add_two_numbers(1,2)` is now `nil`. Because the return value of executing `puts` is always `nil`, the last line evaluates to `nil`, and `nil` is implicitly returned.

Choosing `puts` over `return` isn't troublesome when the only purpose of the method is for a person to read its result, but it renders the method useless for further manipulation in Ruby. `puts` is like an announcer at a sporting event: it comments on the game while independent from the action.

By returning the result of an expression instead of using `puts`, one maintains a reference to that result. One can assign the return value to a variable, for example:
```
def add_two_numbers_and_return(num_one, num_two)
  num_one + num_two
end

def add_two_numbers_and_puts(num_one, num_two)
  puts num_one + num_two
end

x = add_two_numbers_and_return(1, 2) # x is 3
y = add_two_numbers_and_puts(1, 2) # y is nil
```

`add_two_numbers_and_puts(1,2)` is equally unhelpful in conjunction with other methods because the reference to `3` is lost:
```
add_two_numbers_and_puts(1,2) - 1 # equivalent to nil - 1
                                  # (the interpreter throws an error)

add_two_numbers_and_return(1,2) - 1 # evaluates to 2
```
`add_two_numbers_and_return(1,2) - 1` is an example of method chaining. Method chaining is the technique of chaining method invocations into a single statement without using variables to store intermediate results.  `add_two_numbers_and_return(1,2) - 1` is equivalent to:
```
intermediate_sum = add_two_numbers_and_return(1,2)
intermediate_sum - 1
```

<br />


# Scope
Scope refers to the visibility of variables and methods defined in one part of a program to another part of a program. Context is the set of variables and methods available to a given part of a program. Scope determines context. Here's scope and context in practice. Type the following into your repl (like pry):
```
a = 5

def scope_test
  b = 1
  a
end

puts a
scope_test
```
`puts a` successfully prints `5`, but invoking `scope_test` results in an error:
```
undefined local variable or method 'a' for main:Object
(repl):5:in 'scope_test'
(repl):9:in '<main>'
```
What gives? We defined the variable `a` just eight lines prior our method invocation. The first line of a stack trace refers to the code that directly caused the error. Subsequent lines trace how the Ruby interpreter reached the error-inducing code. The invocation of `scope_test` in line 8 led to the erroneous implicit return of `a` in line 5.

Note `in '<main>'` and `in 'scope_test'`. Each phrase indicates the scope of that particular line. `'<main>'` is the top-level scope. `scope_test` has its own separate scope because method definition is an example of a scope gate, an entrance to a new scope.

The variable `a` was defined in the top-level scope and is therefore invisible or "out of scope" to `scope_test`. Referencing `a` from within `scope_test` causes an error because `a` is not in the method's context. The fault is in the method's definition, but the error occurs only upon its invocation, when the Ruby interpreter first parses the method body. Conversely, because `puts a` is in the scope where `a` was defined (the top-level scope), the interpreter successfully executes `puts a`.

What would happen if we were to reference `b` from the top-level scope?
```
a = 5

def scope_test
  b = 1
  a
end

puts b
```
The interpreter throws a similar error. Just as one cannot reference a variable defined in the top-level scope from the scope of a method, one cannot reference a variable defined in a method from the top-level scope.

Because method definition is a scope gate, one can define a variable inside a method with the same name as one already defined in another scope without reassigning the original variable. Even if they share names, variables in distinct scopes are themselves distinct.
```
a = 5

def define_new_variable_a
  a = "not 5"
  a
end

define_new_variable_a #=> "not 5"
a #=> 5
```
This code snippet seems to introduce an exception to this theory of scope:
```
  def howdy
    "Howdy"
  end

  def partner
    howdy + ", partner!"
  end

  partner #=> "Howdy, partner!"
```
How does `partner` invoke `howdy`? Isn't `howdy` defined outside of the scope of `partner`, specifically in the top-level scope? `howdy` is visible to `partner` because howdy is not a local variable. It's a method defined on `main`, a special kind of Ruby object. You'll learn more about `main` later. For now observe that you can invoke methods from within other methods without worrying about scope.

Note: Non-local variables such as class and instance variables can also persist across scopes. Object-oriented programming supplies a more nuanced model of scope and how it relates to `main` and variable types. Again, more on that later.
## Separation of Concerns
`howdy` is a helper method, one that helps another method perform its task by managing a subtask. Say we want to write a method, `num_prime_factors(num)`, that determines the number of prime factors of its argument. This method might delegate to two helper methods:

`factors(num)`, which determines the factors of a number.
`prime?(num)`, which determines whether a number is prime.

The concept of helper methods introduces two principles of software design: Separation of Concerns and the Single Responsibility Principle. Separation of Concerns dictates separating a program into distinct sections that each address a specific concern. The Single Responsibility Principle dictates that each section should entirely encapsulate the functionality for which it is responsible. Modular, encapsulated code is easier to debug and is more readable and recyclable.
