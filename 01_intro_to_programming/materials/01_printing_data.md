# Printing Data

There are a few ways to "print" output to the screen in Ruby. We have been using `puts` frequently in this course, but you can also use `print` and `p`. So many options! However, each method has some unique behavior. Let's step through them.

## print

`print` is the simplest method used to print data. It will do minimal formatting and not even add a new line at the end of the print:

```ruby
print "hello"
print "world"

# the code above would print:
# helloworld
```

To manually add a new line you can use the character `\n`. `\n` stands for "new line." This syntax is often used for other whitespace characters like tab (`\t`).

```ruby
print "hello\n"
print "\tworld\n"

# the code above would print:
# hello
#   world
```

## puts

`puts` also prints data to the screen, but with some formatting, including adding an automatic new line after every puts:

```ruby
puts "hello"
puts "world"

# the code above would print:
# hello
# world
```

## p

`p` prints data to the screen with a new line but also gives information on type of data was printed:

```ruby
p "hello"
p 'goodbye'
p "42"
p 42

# the code above would print:
# "hello"
# "goodbye"
# "42"
# 42
```

Lets notice a few things above:

- it doesn't matter if we wrap a string in double quotes or single quotes, it is still a string (in a later course we'll learn a slight distinction between the two).
- we are able to differentiate the string `"42"` from the number `42` because the `p` method will actually print out the quotes that wrap the string data. Very cool!