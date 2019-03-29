# Glossary

*   **Block** - A way of grouping instructions that's denoted by enclosing curly braces or `do` and `end` keywords; similar to an anonymous function.
*   **Closure** - Structures that capture or "close over" variables in the context in which those structures are defined; like one-way scope gates.
*   **Conditional Statement** - A control structure that instructs the interpreter to execute different branches of code depending on whether a condition is truthy or falsey.
*   **Control Flow** - The order in which instructions are executed within a program.
*   **Control Structure** - An expression that alters the control flow based on analysis of given parameters.
*   **Falseyness** - An object's quality of being false, even if the object is not `false`; `false` and `nil` are falsey.
*   **Truthiness** - An object's quality of being true, even if the object is not `true`; all objects except for `false` and `nil` are truthy.
*   **Infinite Loop** - A sequence of instructions that loops endlessly.
*   **Iteration** - The act of repeating a procedure and each repetition itself.
*   **Iterator** - A method that repeats a set of instructions once for each element in its receiver.
*   **Loop** - A control structure that instructs the Ruby interpreter to repeatedly execute a section of code while a condition holds.
*   **Short-Circuit Evaluation** - When the second operand of a logical operator is evaluated only if the first operand does not suffice to determine the value of the expression.

## Comparison Operators

*   `>` - Greater than; returns a boolean.
*   `<` - Less than; returns a boolean.
*   `>=` - Greater than or equal to; returns a boolean.
*   `<=` - Less than or equal to; returns a boolean.
*   `==` - Equal to; returns a boolean.
*   `!=` - Not equal to; returns a boolean.
*   `<=>` - The spaceship operator; returns -1 if less than, 0 if equal to, 1 if greater than.

## Logical Operators

*   `&&` - The logical AND.
*   `||` - The logical (inclusive) OR.
*   `!` - The logical NOT.

## Iterators

*   `each` - Accepts a block that it invokes once for each element in the receiver collection, passing that element as an argument; returns its receiver.
*   `each_index` - Accepts a block that it invokes once for each element in the receiver collection, passing each index as an argument; returns its receiver.
*   `each_char` - Accepts a block that it invokes once for each character in the receiver string, passing that character as an argument; returns its receiver.