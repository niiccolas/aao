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