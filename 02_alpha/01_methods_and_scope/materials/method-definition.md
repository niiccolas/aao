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