# Control Flow

So far the Ruby interpreter has executed all of our programs in order:

    2+3 #=> 5
    [1,2,3,4].length #=> 4
    "dog" && nil #=> nil  

More sophisticated programs require manipulating **control flow**, the order in which instructions are executed within a program. One modifies control flow using **control structures**, expressions that alter the control flow based on analysis of given parameters. We'll first examine **conditional statements**, which instruct the interpreter to execute different branches of code depending upon whether a condition is truthy or falsey.