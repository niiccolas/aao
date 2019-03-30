# Ruby

## Nontechnical Overview of Ruby
Yukihiro “Matz” Matsumoto released the first version of the Ruby programming language in 1995 in Japan. Ruby is dynamic, reflective, object-oriented, and multi-paradigm. Let’s examine those terms.

### Dynamic

A dynamic programming language is one that can execute many common programming behaviors at runtime (when the interpreter executes the program) that static programming languages perform during compilation, when a program--the compiler--translates high-level source code to a lower-level language (e.g., assembly language or machine code). Dynamic programming languages can compile code at runtime and execute code during compile-time; the compilation and runtime phases are muddled. Though this flexibility enables metaprogramming, more abstraction, and less code, it comes at the expense of execution speed.

Ruby, like most dynamic programming languages, is also dynamically typed. In dynamically typed languages, the language enforces type constraints at runtime; whereas, in statically typed languages, the language enforces type constraints at compile-time. The following method invocation in Ruby runs successfully at runtime:

    def erroneous_addition(x)
      if x > 99999
        print "Luckily I'm a valid statement!"
      else
        print "The Ruby interpreter is about to be a complainy-pants!" + x
      end
    end
    
    erroneous_addition(Float::INFINITY)

Ruby doesn't check the validity of `erroneous_addition` until runtime. The following invocation causes an error because the interpreter encounters the erroneous branch of the conditional statement:

    erroneous_addition(1) # TypeError: no implicit conversion of Fixnum into String

Merely defining an equivalently erroneous method in a statically typed language like Java will result in a compilation error, namely `incompatible types: String cannot be converted to int`.

    class StaticallyTypedError {
      // Many statically typed programming languages require the programmer to specify variable types.
      // The first int refers to the type of the return value of the method.
      // The second refers to the type of the x parameter.
        public static int erroneousAddition(int x) {
          if (x > 99999)
           System.out.println("Luckily I'm a valid statement!");
          else
           System.out.println("Java is already angry!" + x);
    
          return "Java won't even let this method slide uninvoked!";
        }
    };

### Reflective

Reflection is common among dynamic programming languages. Unlike mere type introspection, which refers to the ability of a program to examine the type and state of an object at runtime, reflection refers to ability of a program to manipulate its own structure and behavior as data. In object-oriented reflective languages like Ruby, reflection permits not only the examination of classes, modules, and methods, but also instantiation and method invocation. Reflection makes possible much of metaprogramming. Here's an example adapted from Wikipedia of non-reflective and reflective call sequences in Ruby:

    # nonreflective
    obj = Foo.new
    obj.hello
    
    # reflective
    class_name = "Foo"
    method_name = :hello
    
    # The program can inspect and modify source code constructions such as classes
    # and methods at runtime. It can even convert strings or symbols matching
    # symbolic names of those constructions into references to them.
    obj = Object.const_get(class_name).new
    obj.send method_name
    
    # The program can evaluate a string as if it were source code at runtime.
    eval "Foo.new.hello"

### Object-Oriented

Object-oriented programming is a programming paradigm that privileges objects rather than actions and data rather than functions or logic. Adherents to OOP conceive of a program as a society of objects that receive messages that they then use to perform their own discrete operations. Objects typically contain data in fields known as attributes and a set of associated methods that may access and manipulate these attributes.

The most popular object-oriented languages, such as Java, Perl, Python, Ruby, Objective-C, Smalltalk and Swift are class-based. Objects are instances of classes, which usually determine type. Classes define the data format and methods available to their instances or to themselves.

Classes often inherit from other classes in an "is-a-type-of" relationship. The Dog class (the child class) might inherit from the Pet class (the parent class). The child class inherits data definitions and methods from the parent class, allowing for recycling. The child class may overwrite these definitions and methods as well as add its own, thereby customizing and extending its parent.

Encapsulation is a principle of object-oriented design. It dictates that the programmer:

1.  Place all code concerned with a particular set of data in one class.
2.  Hide methods and data essential only to a class's internal workings (this technique is called information hiding). Conversely, the programmer should expose via methods only what's necessary to a class's relationships with other classes, thereby preventing external interference and misuse.

### Multi-Paradigm

Although Ruby is perhaps the object-oriented programming language par excellence, it also supports procedural and functional programming.

Procedural programming privileges procedure invocations, i.e., method calls. In procedural programming, the programmer specifies a series of procedures that operate on data structures in systematic order. Object-oriented programming joins data structures and methods into "objects" that operate on themselves. Defining and invoking methods outside of a class in Ruby approximates procedural programming because these methods are part of a single root object, limiting object-oriented design.

Functional programming privileges pure functions, those whose return value is only determined by the input, without side effects such as changes in state. Adherents of functional programming conceive of computation as the evaluation of mathematical functions. Via blocks, Ruby shares many features of functional programming languages. Ruby features anonymous functions, lexical closures (functions that capture variables in the context where they're defined), and higher-order functions (functions that can accept functions as arguments and/or return functions). As of Ruby 2.0, Ruby even supports lazy enumeration!

## Philosophy

In 2008, Matz declared that the primary purpose of Ruby is to "help every programmer in the world to be productive, and to enjoy programming, and to be happy." He elaborated:

> Often people, especially computer engineers, focus on the machines. They think, "By doing this, the machine will run fast. By doing this, the machine will run more effectively. By doing this, the machine will something something something." They are focusing on machines. But in fact we need to focus on humans, on how humans care about doing programming or operating the application of the machines. We are the masters. They are the slaves.

Ruby follows the Principle of Least Astonishment: it attempts to minimize confusion for experienced users. Much of Ruby reads like English. It's designed to be expressive, powerful, elegant, and flexible. There are myriad ways to do almost anything in Ruby, a design decision inherited from Perl.

## Ruby vs. Python

Python is perhaps the most similar language to Ruby. Both are dynamic, reflective, object-oriented, multi-paradigm scripting languages. They even use similar syntax! Here are the primary linguistic differences:

1.  Python doesn't support blocks.
2.  Python has a richer set of data structures.
3.  Python is inflexible: there's one best way of doing things!
4.  Whitespace is syntactically significant in Python.
5.  Python is less object-oriented. It has primitive data types, which are more fundamental than objects (not everything in Python is an object!), and many of its object-oriented features were late additions.
6.  Ruby values elegance and "magic" over clarity. Here's how to determine the time one month from now in Ruby versus Python:

        # RUBY
        require 'active_support/all'
        1.month.from_now
    
        # PYTHON
        from datetime import datetime
        from dateutil.relativedelta import relativedelta
        new_time = datetime.now() + relativedelta(months=1)

The most significant difference between Ruby and Python is their communities. For better or worse, Ruby's popularity is tied to Rails. Hence Rails is the testing ground for many innovations in web development. Airbnb, Apple, Github, Groupon, Shopify, and Twitter all use Rails.

Python developers tend to be more conservative in general. Rubyists enjoy many new linguistic features before Python developers catch on.

Because of the popularity of Rails, the fact that Python is older, and the early porting of statistical libraries in R to Python, Python has a more diverse community, including many more proponents in data science and academia. Ruby has no equivalent to Python's SciPy, NumPy, Matplot lib, or NLTK (Natural Language Toolkit) libraries.

Here's an excellent infographic from UpGuard comparing the two languages: [Python versus Ruby](http://assets.aaonline.io/fullstack/ruby/assets/python_vs_ruby.jpg)

## Vocabulary

#### Test-Driven Development (TDD)

TDD is a process for writing software. Its basic steps are as follows:

1.  Add a test
2.  Run all the tests and make sure the new test fails
3.  Write code
4.  Run all the tests and make sure the new test passes
5.  Refactor the code.

### Behavior-Driven Development (BDD)

BDD is an extension of TDD. It structures the testing process through the use of user stories - a description of the user's use of the feature being developed. The goal of the user story is to help focus the developer on what to test and what not to test.

### Unit Test

Unit testing is a way of testing an application by breaking the application down into its smallest constituent parts and testing each part in isolation. In order to test parts of an application that rely on other code, unit tests typically use mock objects to make sure that problems elsewhere in the code won't cause the tests to mistakenly fail.

Unit testing is often automated at larger or more sophisticated companies.

### Integration Test

Integration testing is a form of testing in which units of code are combined ("integrated") and the results of their interactions are tested. This type of testing is done after each of the individual units has been tested.

### Test Coverage

"Test coverage" refers to how much of a software program has been tested. This can refer to several things, including the percentage of functions that have been called by the test suite, or the percentage of statements in the code that have been executed by the test suite.

# Debugging

Any program of sufficient complexity is unlikely to work the first time. You will make mistakes. Skilled and unskilled developers write a similar number of bugs. The difference is that skilled developers are able to quickly identify and fix bugs.

A rule of thumb is that it takes 10x as long to debug code as to write it. Master debugging and you master programming.

## Rule #1: Read the error

Rule #1 is to **READ THE ERROR**.

Do NOT simply jump back to your program and start fiddling with things to see if you can get it to work. Always read the error. Oftentimes it tells you everything you need to know.

The error gives you valuable pieces of information. The first three are absolutely essential to read and understand whenever an error occurs.

*   Error type
*   Error message
*   Line number on which the error occurred
*   Chain of methods that were called leading up to it (referred to as the **stack trace**)

If you encounter an error and you are unclear about what the error type and/or message is telling you, stop and ask an instructor to explain it to you. Learning to understand errors and error messages is critical to developing your abilities as a programmer.

## Perform a Mental Stack Trace

The stack trace below the error message can be extremely helpful, but it usually won't give you the exact information you need to fix your bug. What it does tell you is the path your program took to get to wherever the error happened.

Whenever you encounter a bug your ability to track it down will be dependent on your ability to trace the logic of your own code.

Interrogate your code actively. Why did the bug happen? What are the values of the key variables at key points in your program? What did each line evaluate to leading up to the bug?

Do not passively stare at your code or simply assume that what you think happened is what actually happened (this is what got you in trouble in the first place!). Some strategies include:

*   Break your code down into more testable chunks and actively run each of those chunks to test if they're working.
*   Use `p` statements often; use them to check what the values of variables are, that methods are called as expected, etc.
*   Use the debugger.

The key with bugs and errors is to really get into the mind of the machine. You must understand what is happening in the code. To do so, you must seek out helpful feedback from the program, constantly testing your assumptions about what is happening.

You are a programmer. You hunt bugs. Hunt well.

## Write code that's testable

Let's consider a Ruby script that is supposed to print the first 100 primes:

    # primes.rb
    
    primes = []
    
    num = 1
    while primes.count < 100
      is_prime = true
      (1..num).each do |idx|
        if num % idx == 0
          is_prime = false
          break
        end
      end
    
      if is_prime
        primes << num
      end
    end
    
    puts primes

This program doesn't work; it doesn't look like it ever returns. Where's the bug (or bugs)?

The bugs could be anywhere, but we don't have the ability to isolate and test individual parts of the code. When we load up this file, it immediately starts running all the code.

Let's make this more _testable_: let's break the code into small, bite-sized methods. Small methods are easier to test, because you can test each part independently.

General hint: when you write a _script_, write all your code inside of methods. Only a very little bit of code should be written at the top level to kick things off.

    # primes.rb
    
    def prime?(num)
      (1..num).each do |idx|
        if num % idx == 0
          return false
        end
      end
    end
    
    def primes(num_primes)
      ps = []
      num = 1
      while ps.count < num_primes
        primes << num if prime?(num)
      end
    end
    
    if __FILE__ == $PROGRAM_NAME
      puts primes(100)
    end

This code uses a common trick. We will want to be able to load our code without running it immediately. In particular, we'd like to directly call the methods and diagnose whether each is working. But before we were blocked because the program immediately started executing the script and entering an infinite loop.

The solution is the trick `if __FILE__ == $PROGRAM_NAME`. This checks to see if the currently running program (`$PROGRAM_NAME`) is the same as the current file (primes.rb). If so, then this is being invoked as a script, so we should kick things off. Otherwise, we're loading it as part of some other program (like irb or Pry), and we shouldn't do more than load the method definitions so that someone else may use them.

Great. Now we can test the `prime?` and `primes` pieces individually. If one works and the other doesn't, we can focus on the single broken method. Even if both are broken, we can fix `prime?` first, and then try to debug `primes` knowing that `prime?` at least works.

Also, because `prime?` and `primes` do one simple thing, we know what they're _supposed_ to do: `prime?(2)` should be true. `prime?(4)` should be false. `primes(3)` should be `[2, 3, 5]`.

This is better than a huge, black-box method which does a bunch of complicated stuff where it's hard to even know what the right answer should be.

### Pay technical debt

If you encounter buggy code that is poorly decomposed into methods, **fix the design immediately**. You're going to want to fix the design eventually anyway; refactoring will probably create new bugs to fix, so you might as well deal with this bug at the same time.

More importantly, good code is the gift that keeps on giving. If this code is broken today, it's safe to assume that it will bite you in the ass with another bug a few days from now, too. And every time you come back to this code, you'll be fighting its poor design as you try to deal with it. Try to fix it now once and for all.

In the rush to complete projects, bad design is sometimes a compromise made to finish a project on-time. This is called _technical debt_. It's okay to take out debt like this, just like it's okay to take out financial debt. But the more debt you take out, the higher the payments in the form of your time.

If you find yourself struggling with a tough bug in the midst of some poorly written code, admit that your debt has caught up with you, bite the bullet and refactor.

## Don't read the source

We haven't found out what's wrong yet. You might be tempted to first look carefully at `prime?` and `primes`, try to reason through them, and spot the bug. You may be able to do this with my simple example.

**Do not spend more than 1min doing this in real life**. Yes, many silly bugs can be spotted if you stare at the code, but many other silly bugs are difficult to spot because our eyes play tricks on us. You know how you can still read a paragraph with the spaces taken out? For the same reason, it's hard to spot silly bugs, because you know what the code is _supposed_ to do.

Your bug may not be a simple bug. If it's at all non-trivial, it will be _very_ hard to spot. The best way to find a bug like this is to take your code step-by-step. We'll see how to do that soon.

Yes, when debugging you should look at the source to familiarize yourself with the code. The bug may jump out at you. If not, don't worry. We're about to learn better techniques.

## Use a REPL to isolate the problem

Now that we've broken the code up into testable bits, let's actually test those parts. That lets us quickly isolate the problem to a few lines.

Open the Pry REPL. Make sure you have done `gem install pry` first.

    david ~/Dropbox/TA $
    pry

Load your file and start testing.

    [1] pry(main)> load 'primes.rb'
    => true
    [2] pry(main)> prime?(2)
    => false

Awesome. We've already found a _regression_; an input which produces the wrong output. There might also be problems with `primes`, but it would have been a real PITA to try to fix those when the underlying `prime?` method is broken.

Decomposition for the win.

Now we need to take a more fine-grained look at exactly what is wrong with our `prime?` method.

## Use a debugger to zero in on the problem

In Ruby versions 2.0 and greater, we use byebug for debugging:

`gem install byebug`

Byebug lets us do many cool things. We can step through our code one line at a time, and along the way...

*   check the value of our variables at any time (no `p` required!)
*   continuously watch the value of a variable, so that we can see when it changes
*   change the value of variables in the middle of program execution
*   set breakpoints so that we can pause whenever we reach a certain line in our code
*   examine the call stack to determine exactly which methods brought us to a certain line of code
*   execute short snippets of code to test an idea (just like in pry or irb)

Note: a minor downside of the byebug gem is that it does not support colored syntax highlighting. However, I will apply coloring to the following examples so that they are easier to read.

## Step through code

Once you've isolated a bug to a small amount of code, the best way to uncover the problem is to single-step through the code, checking what the program does along the way. This is what a _debugger_ (such as byebug) does.

To start, we need to modify our program slightly so that we _drop into_ the debugger when `prime?` is called:

    require 'byebug'
    
    def prime?(num)
      debugger # drops us into the debugger right after this point
    
      (1..num).each do |idx|
        if num % idx == 0
          return false
        end
      end
    end
    
    def primes
      # ... etc.

**N.B.** Don't forget to `require 'byebug'` at the top of your file.

Let's load our code into pry and call `primes?(2)` to start testing the `primes?` method. The `debugger` at the top of `prime?` will pause our code there. At this point, you are basically like [Neo](http://img1.wikia.nocookie.net/__cb20131002032735/matrix/images/b/b5/Matrix-neo-stops-bullets-wallpaper.jpg).

    david ~/Dropbox/TA $
    pry
    [1] pry(main)> load 'primes.rb'
    => true
    [2] pry(main)> prime?(2)
    
    [1, 10] in primes.rb
        1: require 'byebug'
        2:
        3: def prime?(num)
        4:   debugger # drops us into the debugger right after this point
        5:
    =>  6:   (1..num).each do |idx|
        7:     if num % idx == 0
        8:       return false
        9:     end
       10:   end
    (byebug)

We are now inside of the byebug debugger, inside of the pry REPL. (Note that the byebug debugger is not built into pry. If we didn't have `require 'byebug'` at the top of our file then pry would have raised an error when it came to line 4.) The debugger prompt looks like `(byebug)`. Our position is indicated by the arrow; we're at line 6.

On line 6 we are calling the `each` method on the range `(1..num)`. `step` (or `s`) is the command that we use to step into a method call. There is a bug in Ruby 2.1 that causes us to get stuck on line 6 the first time we type `step`, so we'll have to `step` twice.

    (byebug) step
    
    [1, 10] in primes.rb
        1: require 'byebug'
        2:
        3: def prime?(num)
        4:   debugger # drops us into the debugger right after this point
        5:
    =>  6:   (1..num).each do |idx|
        7:     if num % idx == 0
        8:       return false
        9:     end
       10:   end
    (byebug) step
    
    [2, 11] in primes.rb
        2:
        3: def prime?(num)
        4:   debugger # drops us into the debugger right after this point
        5:
        6:   (1..num).each do |idx|
    =>  7:     if num % idx == 0
        8:       return false
        9:     end
       10:   end
       11: end
    (byebug)

You can see how the arrow has advanced. Let's see what happens at this if statement. Since there is no method call on line 7, we advance with `next` (or `n`).

    (byebug) next
    
    [3, 12] in primes.rb
        3: def prime?(num)
        4:   debugger # drops us into the debugger right after this point
        5:
        6:   (1..num).each do |idx|
        7:     if num % idx == 0
    =>  8:       return false
        9:     end
       10:   end
       11: end
       12:
    (byebug)

Wait; we entered the `if`? How? Let's check the values of `num` and `idx`:

    (byebug) num
    2
    (byebug) idx
    1

Hmm... We shouldn't check for divisibility by one. Upon reflection, we shouldn't start the index at 1 at all; we should start at 2\. We can quit byebug by typing `exit`, then `y` to confirm.

Let's fix our code:

    def prime?(num)
      debugger
    
      (2..num).each do |idx|
        if num % idx == 0
          return false
        end
      end
    end

Let's go back into pry and see if `prime?` works now:

    david ~/Dropbox/TA $
    pry
    [1] pry(main)> load 'primes.rb'
    => true
    [2] pry(main)> prime?(2)
    
    [1, 10] in primes.rb
        1: require 'byebug'
        2:
        3: def prime?(num)
        4:   debugger
        5:
    =>  6:   (2..num).each do |idx|
        7:     if num % idx == 0
        8:       return false
        9:     end
       10:   end
    (byebug)

We still have our `debugger` on line 4, and so we stop at the next line of code (line 6). Right now, though, we don't want to debug step-by-step; we just want to see the result of calling `prime?(2)`. We can type `c` (for `continue`) to tell the debugger to keep running the code.

        9:     end
       10:   end
    (byebug) c
    => false
    [3] pry(main)>

The code never brought us back to the debugger at line 4, so the method finished, and spit us back out at the pry prompt. We can see that our method returned false, though, so we still have work to do.

The line we really want to focus on is line 8, because that's where we are erroneously returning `false`. So, let's add a breakpoint to line 8 with the `break` command. This tells byebug to make sure to stop when we hit line 8. I then tell the program to run freely until it hits a breakpoint (`c`, or `continue`), and shortly thereafter we arrive at line 8.

    [3] pry(main)> prime?(2)
    
    [1, 10] in primes.rb
        1: require 'byebug'
        2:
        3: def prime?(num)
        4:   debugger
        5:
    =>  6:   (2..num).each do |idx|
        7:     if num % idx == 0
        8:       return false
        9:     end
       10:   end
    (byebug) break 8
    Created breakpoint 1 at primes.rb:8
    (byebug) c
    Stopped by breakpoint 1 at primes.rb:8
    
    [3, 12] in primes.rb
        3: def prime?(num)
        4:   debugger
        5:
        6:   (2..num).each do |idx|
        7:     if num % idx == 0
    =>  8:       return false
        9:     end
       10:   end
       11: end
       12:
    (byebug)

Now we can have a look at the relevant variables.

    (byebug) num
    2
    (byebug) idx
    2

Groan. We are testing whether `num` is divisible by itself. That's because `(2..num)` includes num; we wanted `(2...num)`. Fix and then reload:

    [1] pry(main)> load 'primes.rb'
    => true
    [2] pry(main)> prime?(2)
    
    [1, 10] in primes.rb
        1: require 'byebug'
        2:
        3: def prime?(num)
        4:   debugger
        5:
    =>  6:   (2...num).each do |idx|
        7:     if num % idx == 0
        8:       return false
        9:     end
       10:   end
    (byebug) c
    => 2...2
    [3] pry(main)>

Weird, but better; at least this isn't false. But because we don't return `true` at the end of `prime?`, the last returned value is used. Note that `Enumerable#each` returns `self`; in this case the range itself. Let's finish fixing this method.

    def prime?(num)
      (2...num).each do |idx|
        if num % idx == 0
          return false
        end
      end
    
      true
    end

Does it really work? We ought to check with a few values other than 2:

    [5] pry(main)> load 'primes.rb'
    => true
    [6] pry(main)> prime?(2)
    => true
    [7] pry(main)> prime?(3)
    => true
    [8] pry(main)> prime?(10)
    => false
    [9] pry(main)> prime?(17)
    => true

All looks good. Notice how we can quickly check a number of values in the REPL.

## Reading stack traces

Now that `prime?` appears to be working, it's time to test `primes`. I've put a call to `debugger` at the start of `primes`. Again, let's use pry:

    [10] pry(main)> load 'primes.rb'
    => true
    [11] pry(main)> primes(2)
    
    [11, 20] in primes.rb
       11: end
       12:
       13: def primes(num_primes)
       14:   debugger
       15:
    => 16:   ps = []
       17:   num = 1
       18:   while ps.count < num_primes
       19:     primes << num if prime?(num)
       20:   end
    (byebug) c
    ArgumentError: wrong number of arguments (0 for 1)
    from primes.rb:13:in 'primes'

The method failed. When an exception is thrown and no code catches and handles the exception, then the program stops (crashes) and the exception and line where it occurred are printed.

The line `ArgumentError: wrong number of arguments (0 for 1)` states the exception type (`ArgumentError`) and the message. This message says that we're passing the wrong number of arguments to a method: zero arguments instead of one argument.

Where did this happen in the code? The subsequent line tells us: `from primes.rb:13:in 'primes'`. If we want more detail about just how we came to this line of code, we can type `wtf` to look at the _stack trace_. (You can also add question marks and exclamation points to get longer stack traces, like `wtf?`, `wtf?!!`, etc.)

    [9] pry(main)> wtf
    Exception: ArgumentError: wrong number of arguments (0 for 1)
    --
    0: /home/david/Dropbox/app-academy-TA/primes.rb:13:in 'primes'
    1: /home/david/Dropbox/app-academy-TA/primes.rb:19:in 'primes'
    2: (pry):21:in '__pry__'
    3: /home/david/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/pry-0.10.1/lib/pry/pry_instance.rb:355:in 'eval'
    4: /home/david/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/pry-0.10.1/lib/pry/pry_instance.rb:355:in 'evaluate_ruby'
    [10] pry(main)>

The top line of the stack trace tells us what method (`primes`) and line of code (13) were executing when the error occurred. The next line tells us what called `primes`; it looks like `primes` calls itself, on line 19\. The next line starts with '(pry)'; this is pry executing the code we gave it.

It's certainly odd that primes is calling itself. Let's check this out:

    [12] pry(main)> primes(2)
    
    [11, 20] in primes.rb
       11: end
       12:
       13: def primes(num_primes)
       14:   debugger
       15:
    => 16:   ps = []
       17:   num = 1
       18:   while ps.count < num_primes
       19:     primes << num if prime?(num)
       20:   end
    (byebug)

Ah. Line 19 says that if `prime?(num)`, then `primes << num`. This tries to call `primes` again, but what we really wanted was to push `num` into our list, named `ps`. This is confusing because it's not super clear that `primes` is calling a method (equivalent to `self.primes`).

Fix this and restart `pry`.

    [13] pry(main)> load 'primes.rb'
    => true
    [14] pry(main)> primes(2)
    
    [11, 20] in primes.rb
       11: end
       12:
       13: def primes(num_primes)
       14:   debugger
       15:
    => 16:   ps = []
       17:   num = 1
       18:   while ps.count < num_primes
       19:     ps << num if prime?(num)
       20:   end
    (byebug) c
    => nil

Oops. A few more simple bugs. You catch them.

## Step vs Next

Here, using `n`, I have line by-line advanced through `primes`:

    [14, 23] in primes.rb
       14:   debugger
       15:
       16:   ps = []
       17:   num = 1
       18:   while ps.count < num_primes
    => 19:     ps << num if prime?(num)
       20:   end
       21: end
       22:
       23: if __FILE__ == $PROGRAM_NAME
    (byebug)

I could type `n` to execute this line and advance (back to line 19, actually). But what if I wanted to "step into" the call to `prime?`? To do this, I use `s` or `step`:

    (byebug) step
    
    [1, 10] in primes.rb
        1: require 'byebug'
        2:
        3: def prime?(num)
    =>  4:   (2...num).each do |idx|
        5:     if num % idx == 0
        6:       return false
        7:     end
        8:   end
        9:
       10:   true
    (byebug)

This is handy when you want to go down into methods. If I'm no longer interested in stepping through all of `prime?`, I can finish it and move up a level by using `finish`:

    (byebug) finish
    
    [14, 23] in primes.rb
       14:   debugger
       15:
       16:   ps = []
       17:   num = 1
       18:   while ps.count < num_primes
    => 19:     ps << num if prime?(num)
       20:   end
       21: end
       22:
       23: if __FILE__ == $PROGRAM_NAME
    (byebug)

## Debugging and Testing

We've gone through a lot of work testing that these methods work as they should. It would be good if we could record these tests so that they can be run in the future, to make sure new bugs do not sneak in as we continue to develop the software. We'll talk later about RSpec, a way to write tests that can be automatically run by a system called Guard.

When a bug is discovered, it is good practice to write a new test that verifies we don't make that mistake again.

## Resources

*   [why Pry is awesome](http://www.sitepoint.com/rubyists-time-pry-irb/)
*   [Byebug documentation](https://github.com/deivid-rodriguez/byebug/blob/master/README.md)

# Common Exceptions

There are several exceptions that frequently come up. They can be mysterious at first. Exceptions are trying to tell you what went wrong, so being able to understand them is important. Here are the most common.

## Goals

*   Know these most common exceptions and what they signify.

## NameError

A `NameError` exception is thrown when you try to use a variable or method that hasn't been defined.

    class NumbersClass
      def answer_number
        42
      end
    
      def loneliest_number
        1
      end
    
      def numbers
        [favorite_nmber, loneliest_number]
      end
    end
    
    [3] pry(main)> nc = NumbersClass.new
    => #<NumbersClass:0x007ff9dc12c608>
    [4] pry(main)> nc.numbers
    NameError: undefined local variable or method `favorite_nmber' for #<NumbersClass:0x007ff9dc12c608>
            from: /Users/ruggeri/test.rb:11:in `numbers'
            from: (pry):4:in `__pry__'

Here we've mistyped the method name; the error tells us the name `favorite_nmber` hasn't been defined. Ruby looks for either a local variable or a method. It tells you that it was looking for the method `favorite_nmber` defined on the NumbersClass.

### Uninitialized Constant

Here's a variation on your standard NameError:

    [3] pry(main)> UnloadedClass.new
    NameError: uninitialized constant UnloadedClass
            from: (pry):3:in `__pry__'

"Uninitialized constant" means that Ruby is trying to find a class (or other constant), but didn't find it. This could be because of a class name typo, or often because we forgot to `require` the Ruby file that loads the class.

You'll get this variation if the name starts with an upper-case letter, since in Ruby variables/methods start with lower case letters, and classes start with upper case letters.

### NoMethodError

This is similar to NameError; in fact it's a subclass. This is thrown when it's clear the user wanted to call a method (didn't try to look up a variable) that doesn't exist:

    [1] pry(main)> "my string".my_fantasy_method
    NoMethodError: undefined method `my_fantasy_method' for "my string":String
            from: (pry):1:in `__pry__'

Again, Ruby tells us the method name it looked up, and the object.

A particularly common error occurs when a variable is `nil` when we don't expect this

    [5] pry(main)> my_array[0] # what if my_array == nil?
    NoMethodError: undefined method `[]' for nil:NilClass
            from: (pry):2:in `__pry__'

`nil` is an instance of the class `NilClass`, which doesn't have the method we want.

## ArgumentError: wrong number of arguments

If we don't give a method the right number of arguments, we will get an exception thrown at us:

    [12] pry(main)> [1, 2, 3].shuffle("unwanted argument")
    ArgumentError: wrong number of arguments (1 for 0)
            from: (pry):9:in `shuffle'

Here we give the `shuffle` method an argument when it doesn't take one. Ruby throws an `ArgumentError` exception back at us; it tells us that we passed the wrong number of arguments. It even says that we passed 1 argument when 0 were expected.

## TypeError

A `TypeError` may be thrown if you pass the wrong type of thing to a method. For instance, numbers can only add other numbers:

    [8] pry(main)> 2 + ""
    TypeError: String can't be coerced into Fixnum
            from: (pry):8:in `+'

Here, we try to add a `String` to a number (`Fixnum` is the standard integer class). The method `+` works by first trying to turn its argument into a `Fixnum`, then adding it. A `String` cannot be turned into a `Fixnum` (coerced), so the method complains.

This error normally occurs when you call a method with the wrong types of things. For instance:

    > [] + ""
    > [] + 2
    > "" + 2
    > "" + []

None of these operations make sense; all of them will throw a `TypeError`.

## LoadError

Load errors are common:

    [2] pry(main)> require 'primes.rb'
    LoadError: cannot load such file -- primes.rb

There are two very common causes. Sometimes you are trying to load a file that is provided by a gem, but you haven't installed the gem yet.

Another common cause is that you are trying to load another source file in your project, but you forgot the initial './'. _Relative_ includes are used to include files that are inside your project, you write them like this:

    [2] pry(main)> require './primes.rb'

Of course, the file can be be in a subdirectory:

    [2] pry(main)> require './path/to/source/file/primes.rb'

## SyntaxError

Writing ungrammatical Ruby code will net you a `SyntaxError`. This tells you that Ruby didn't understand your code.

There are lots of sources of syntax errors. The most common are forgetting to close quotes, parentheses, or do-end blocks.

Consider a source file that fails to close a do block:

    [1, 2, 3].each do |num|
      puts num
    # end should go here

When you load this source file, you'll get:

    [1] pry(main)> require './test.rb'
    SyntaxError: /Users/ruggeri/test.rb:3: syntax error, unexpected $end, expecting keyword_end
            from: /Users/ruggeri/.rvm/rubies/ruby-1.9.3-p194/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
            from: /Users/ruggeri/.rvm/rubies/ruby-1.9.3-p194/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
            from: (pry):1:in `__pry__'

Here `$end` means the end of the source file. Here Ruby is telling you that it didn't expect the end of the file ($end) before the keyword `end` (`keyword_end` in the error message).

You can get a similar message with too many ends:

    [1, 2, 3].each do |num|
      puts num
    end
    end # one too many
    
    [2] pry(main)> load './test.rb'
    SyntaxError: /Users/ruggeri/test.rb:4: syntax error, unexpected keyword_end, expecting $end
    end # one too many
       ^
            from: (pry):2:in `load'

This just reverses the prior message; we hit the keyword `end` when we were expecting the end of the file; that is, when we weren't expecting one.

# More Byebug Commands: display and where

## Where you are in the code: `list=`

When you pause on a line of code in byebug, byebug prints out that line (with a `=>` next to it) and a few lines above and below to show you where you are in the code. But if you then run a number of commands while you are paused on a given line, then the listing of where you are in the source code might get pushed off the top of the screen. Instead of scrolling back up to remind yourself precisely which line you are paused at, just type `list=` to re-display where you are paused in the source code.

## Watching a variable

Suppose that you've figured out that a certain variable is causing your program to misbehave. Good! Now you need to figure out when and why that variable is taking on unexpected values. Byebug's `display some_variable` command can help you with that.

The following program does not have a purpose (and therefore does not have any meaningful bugs), but it will serve as a simple example of how to use the `display` command in byebug. The program simply loops through the numbers 1-100 and calculates their squares and halves:

    # display_demo.rb
    (1..100).each do |num|
      square = num ** 2
      half = num / 2.0
      debugger
    end

Run the program, requiring byebug at the command line. We'll be dropped in just after our `debugger`.

    david ~/Dropbox/TA/debugging $ ruby -r byebug display_demo.rb
    
    [1, 5] in display.rb
       1: (1..100).each do |num|
       2:   square = num ** 2
       3:   half = num / 2.0
       4:   debugger
    => 5: end

Let's watch the value of the `square` variable using `display`. Now, byebug will automatically print the value of `square` each time it pauses somewhere in our code (such as after we type `n`, or we arrive at a `debugger` or a breakpoint after `c`ontinuing.)

    (byebug) display square
    1: square = 1
    (byebug) c
    1: square = 4
    
    [1, 5] in display.rb
       1: (1..100).each do |num|
       2:   square = num ** 2
       3:   half = num / 2.0
       4:   debugger
    => 5: end
    (byebug) c
    1: square = 9
    
    [1, 5] in display.rb
       1: (1..100).each do |num|
       2:   square = num ** 2
       3:   half = num / 2.0
       4:   debugger
    => 5: end
    (byebug)

You can add additional variables at any time. By entering `display half`, we will now also see the value of the `half` variable each time we pause in our code.

    (byebug) display half
    2: half = 1.5
    (byebug) c
    1: square = 16
    2: half = 2.0
    
    [1, 5] in display.rb
       1: (1..100).each do |num|
       2:   square = num ** 2
       3:   half = num / 2.0
       4:   debugger
    => 5: end
    (byebug) c
    1: square = 25
    2: half = 2.5
    
    [1, 5] in display.rb
       1: (1..100).each do |num|
       2:   square = num ** 2
       3:   half = num / 2.0
       4:   debugger
    => 5: end
    (byebug)

## Looking at the call stack: `where`

You have seen stack traces when an error is raised in your program. The `where` command allows you to view the stack trace without having to raise an error. This can be handy.

Suppose that you have a method that is called from different parts of your program. Usually the method works as expected, but every once in a while your method raises an error or produces an unexpected result. The method itself might be fine, but maybe it's being called with bad parameters. However, you don't want to go to all of the different places in your program where the method is called and put a `debugger` statement at each one to diagnose the problem, especially if the method calls are spread across different classes and files.

It would be much easier if we could put a single debugger within the method in question, and then _look back_ to see where that method was actually called in the code. Then, once you know where the problem originated, you can fix it. With byebug, you can do just this, using the `where` command.

Consider this program:

    # building.rb
    class Building
      def initialize
        @temperature = 70
      end
    
      def set_thermostat(temp)
        @temperature = temp
      end
    end
    
    house = Building.new
    
    # imagine this is called in one part of your program
    house.set_thermostat(50 * 4 - 2 - 100 + -30)
    
    # and here set_thermostat is set within some other distant class
    house.set_thermostat(200 * 0.5 - 40 + 30 / 2)
    
    # and who knows where this call to set_thermostat could be coming from
    house.set_thermostat(100 / 3 + 80 - -30 + 3)

You notice that sometimes the house is getting too hot, but which part of your program is causing this problem?

We can set up a _conditional debugger_ (line 7 below) that will be triggered when the thermostat is being set too high. Then we can look back and see who was calling `set_thermostat` with an inappropriately high value.

    david ~/Dropbox/TA $ ruby -r byebug building.rb
    
    [3, 12] in building.rb
        3:     @temperature = 70
        4:   end
        5:
        6:   def set_thermostat(temp)
        7:     debugger if temp > 90
    =>  8:     @temperature = temp
        9:   end
       10: end
       11:
       12: house = Building.new
    (byebug) where
    
    --> #0  Building.set_thermostat(temp#Fixnum) at building.rb:8
        #1  <main> at building.rb:21
    (byebug)

Ah ha! We entered the debugger because we met the condition `temp > 90`. Then `where` shows us the call stack. The top of the call stack shows where we are now (#0). Moving down, we move through the previous method calls. In this case, there is just one previous method call, originating at line 21 of `building.rb` (the third call to `set_thermostat`). How easily we have found the culprit!

# Debugging Cheatsheet

If you're banging your head against the wall, some tips:

1.  Find the top line that looks familiar. Put a debugger on that line. Print out everything that shows up on the line.
2.  Google it
3.  If there are lines of code that are really long, break them down into parts.
4.  Trace back: "What method calls `check_valid_move?`? Where does `cats` get assigned? Let's put a debugger there." Keep working "backwards" towards the source.
5.  Comment out lines of code until the error changes.
6.  Go back to when you had it working and see what changed.
7.  Reference the [learn how to debug](https://asherkingabramson.com/blog/productivity/learn-to-debug) blog post.

# Breaking Confusing Methods Into Parts

Consider this line of code:

    exp(b, n) = b * exp(b, n - 1)

It's math, so it's sort of readable. But `exp`, `b` and `n` are still terrible names for variables. They're too short.

Copy this line of code into a new text file. Starting with the first code that runs on the line, name each part of the line as descriptively as you can on a separate line. Then try walking through what's happening.

Start by rewriting it as:

    exponent(base, power) = base * exponent(base, power - 1)

Then, `power - 1` runs first. So rewrite as:

    smaller_exponent = power - 1
    exponent(base, power) = base * exponent(base, smaller_exponent)

Then:

    smaller_exponent = power - 1
    base_to_the_smaller_exponent = exponent(base, smaller_exponent)
    
    exponent(base, power) = base * base_to_the_smaller_exponent

Resulting in:

    exponent(base, power) = base * base_to_the_smaller_exponent

See how much clearer that last line is? Your code should read like Hemingway.

### Two important takeaways

1.  We named the variables as descriptively as possible.
2.  We broke complicated lines down into parts.

Hold yourself to these standards almost every time you write code.

### A Counterargument

You might ask: doesn't naming variables slow me down?

There are four major reasons that long variable names are much faster for you in the long run.

1.  Over the coming weeks, you're about to get a lot better at typing quickly.
2.  Your text editor (i.e., VS Code, Atom, Sublime Text) will autocomplete long variable names.
3.  It's easier for someone else to read your code.
4.  You reduce the amount of data in your [working memory](https://en.wikipedia.org/wiki/Working_memory), because you don't have to remember what abbrevations stand for what concepts. Less data in your working memory gives you more space to tackle new problems.

##Short Exercise

The method below estimates how much money your child will have when they retire, based on your age.

        def return_number(a)
          ((a / 2)**2) * (65 - (a / 2))
        end

Sample Inputs and Outputs:

*   An input of 30 should output 11250
*   An input of 50 should output 25000

You know the algorithm involves these steps in some order:

*   Calculate how much money they'll have by multiplying by the number of years they have left until retirement.
*   Estimate your child's current bank account by squaring their age.
*   Estimate your child's age by dividing your age by two.
*   Calculate how many years your child has left until they retire at age 65

The method is written so poorly, it may as well be the script for Home Alone 4\. There are one-letter variables and there's too much happening on one line.

Rewrite the method by identifying the first operations that run (HINT: find the innermost parentheses). Then copy these operations onto separate lines (like the "exponent" example above) and use descriptive variable names.

DO NOT try to write the algorithm from scratch. That is NOT the point of the exercise.

Finally, rewrite the name of the method itself. Methods that have a side-effect (modify state) should be named with verbs, e.g. `#activate_account` or `#reveal_card`. Methods that return a useful value should be named with nouns describing their output, e.g. `#full_name` or `#days_since_last_login`.

Test that the method still returns the right output by running the code in pry.

Then check with a TA and see if the naming makes sense to them. The code should almost look like english once you're done with it.

### Projects:
* [Enumerables]()
* [Ghost]()

### Bonus Projects:
* [Maze Solver]()

### Solutions: 
* Ghost-1: https://github.com/JoyJing1/aa_w1d1 *works*
* Ghost-2: https://github.com/JoyJing1/aa_w1d1 *not working* - but thanks to this person I don't feel as bad that I've had trouble with this one...
* ghost-solution: the App Academy solution