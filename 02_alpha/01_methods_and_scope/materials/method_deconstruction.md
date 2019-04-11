# Method Deconstruction
'lcm' stands for Least Common Multiple. Every number has multiples. The 'lcm' is the lowest multiple shared by two numbers. For example:

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