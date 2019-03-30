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