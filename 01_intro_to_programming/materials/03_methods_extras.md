# Methods Extras

#### Method or Function?

You may hear the terms *method* and *function* used interchangeably in programmer talk. *Technically* they refer to slightly different things, but we'll save this battle for another day. In a broad sense, *method* and *function* are just terms we use to describe a chunk of executable code. To be truly correct we should only say *method* when talking about Ruby. Occasionally in our video walkthroughs we'll fall victim to the relaxed terminology (Get it together, Alvin).

#### Parentheses?

Ruby is flexible in where we can use parentheses when dealing with our methods. If a method does not expect any parameters, we prefer to call the method without using parentheses. This is a common convention, although ruby will accept either style. See the example below.

```ruby
def greet
  puts "hello world"
end

# Below are two valid ways to call the greet method.
greet   # this is preferred since greet does not expect parameters
greet()
```

Parentheses are also optional when calling methods that do expect parameters. However, we prefer to call methods with parentheses in that scenario:

```ruby
def greet(name)
  puts "hey " + name
end

# Below are two valid ways to call the greet method.
greet "programmers"
greet("programmers") # this is preferred since greet does expect parameters
```

#### Some Terminology

Let's get on the same page about some terminology you'll hear in the upcoming videos. What's the distinction between a **variable**, **parameter**, and **argument**?

**Variables** are names that can hold data. Below, `food` is a variable that holds the value `"toast"`:

```ruby
  food = "toast"
```

**Parameters** are the names that can hold data in a method *definition*. Parameters are placed in parentheses following the method's name. Below `food` and `drink` are parameters. `sentence` is a normal variable; it is not a parameter:

```ruby
  def meal(food, drink)
    sentence =  "I like to eat " + food + " with a cup of " + drink
    puts sentence
  end
```

**Arguments** are the data values that we pass into a method when we call the method. We place arguments in the parentheses of a method call. Those argument values will be assigned to the parameters when we evaluate the method. Below, `"toast"`, `"coffee"`, `"pancakes"`, `"orange juice"` are arguments:

```ruby
def meal(food, drink)
  sentence =  "I like to eat " + food + " with a cup of " + drink
  puts sentence
end

meal("toast", "coffee") # Here we pass "toast" and "coffee" into our method.
meal("pancakes", "orange juice") # We can also pass "pancakes" and "orange juice" in another call
```

In other words, *Arguments* are the concrete data values we pass into method calls. *Parameters* are the "placeholders" that we use to write a general method.