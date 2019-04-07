# Equality in Ruby

Here is a quick overview of the different equality operators in Ruby.

## `#==` (Value Equality)

This is the most fundamental check for equality, it checks if two objects have the same value.

In classes that you write, `#==` is inherited from the Object class. By default, it will return true if and only if the two objects are literally the same object (pointer equality). This default behavior is not particularly helpful, so you should override it.

This is your chance as the class author to decide what it means for two objects to have the same value.

## `#eql?` (Hash Equality)

Like `#==`, `#eql?` assesses general equality. Unlike most implementations of `#==`, `#eql` uses the objects' `#hash` method to assess equality. So `a.eql? b` is equivalent to `a.hash == b.hash`.

If you would like to provide a meaningful `#eql?` method for your classes, you will need to override the `#hash` method.

As an example of "meaningful" `#eql?` methods `#==` performs type conversion amongst numerics (*e.g.* `Float` to `Integer`), but `#eql?` does not.

```ruby
   3.0 == 3 #=> true
   3.0.eql? 3 #=> false
```

This is because `Float#hash` and `Integer#hash` are not the same.

Now that you know that `#eql?` is used by `Hash` to check if an object is a key in a hash, you should not be surprised by this *gotcha*:

```ruby
some_hash = { 3 => 'the third' }
some_hash[3.0] #=> nil
some_hash[3] #=> 'the third'
```

As an exercise for the reader, I suggest playing with using Arrays and Hashes as the keys to a Hash, and seeing what happens when you modify the keys. See below:

```ruby
some_array = [1]
some_hash = { some_array => 'secrets' }
some_array << 2
some_hash[some_array] #=> ???
```

## `#equal?` (Identity Equality)

`#equal?` does simple identity comparison (pointer comparison). *i.e.* `a.equal? b` if and only if `a` is the same object as `b`. This is identical to the default behavior of `#==` in the `Object` class.

```ruby
class Dog
   # ...
end

a = Dog.new
b = Dog.new
a = c

a.equal? b #=> false
a.equal? c #=> true
```

`#equal?` should *never* be overridden.

## `#===` (Case Equality)

`#===` has the same behavior as `#==` for most classes (and by default for classes that you write). This is the method that `case` uses to determine which block to execute.

```ruby
case a
when b
   # ...
when c
   # ...
else
   # ...
end
```

Is equivalent to:

```ruby
if b === a # triple equals!
   # ...
elsif c === a
   # ...
else
   # ...
end
```

I encourage you to override `#===` if you want to add advanced `case`/`when`behavior to your class. As an example, `Integer#===` checks to see if the argument is of type Integer ( `Integer === 3 #=> true`). So you can do this:

```ruby
case number
when Integer
   # ...
when Float
   # ...
end
```

Also, check out what you can do with `Regexp#===` (from this [StackOverflow post](http://stackoverflow.com/a/1735777))

```ruby
tracking_service = case number
   when /^.Z/ then :ups
   when /^Q/ then :dhl
   when /^96.{20}$/ then :fedex
   when /^[HK].{10}$/ then :ups
end
```

## Equality and Hash Keys

If you want to use instances of a class as hash keys, you need to know how a Hash uses the `eql?` equality method. When you give a hash a key to look up its associated value, the hash first looks for an existing key object whose `hash`method returns a value equal to that returned by the given key's `hash` method. Next, it checks if `found_key_object.eql?(given_key_object)`, verifying that, in addition to having the same hash, the found key and the given key should be considered equal. Only if both these tests pass will the hash return the desired value instead of `nil`.

Here's what's going on. Say we have a cat class with a name, and we simply use the hash of the string name as our cat hash value:

```ruby
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def hash
    @name.hash
  end
end
```

And say we create an entry in a hash using a `Cat` instance as a key:

```ruby
hash = {}
cat1 = Cat.new('Fluffy')
hash[cat1] = 'is the best cat'
```

If we create another `Cat` instance with the same name, then try to use it to look up the value stored with the first instance, the hash won't be able to find it. This is a problem, as we want two `Cat` instances with the same data (name) to be treated as the same key by the hash:

```ruby
hash[cat1] #=> 'is the best cat'
cat2 = Cat.new('Fluffy')
hash[cat2] #=> nil
```

This happens because our class inherits the default `eql?` method from `Object`, which simply tests for pointer equality. To get this working, we need to define `Cat#eql?` so it returns true if both cat instances have the same name:

```ruby
class Cat
  def eql?(other)
    self.name == other.name
  end
end

hash[cat2] #=> 'is the best cat'
```

The takeaway is that if you have created a class and you want to use it as a key in a hash, you should define `#hash` and `#eql?`.

## Further Reading

The interested student should read more about them in the [`Object`documentation](http://ruby-doc.org/core-2.1.2/Object.html), and in the awesome Stack Overflow post reproduced below.


### [What's the difference between equal?, eql?, ===, and ==?](https://stackoverflow.com/questions/7156955/whats-the-difference-between-equal-eql-and/7157051#7157051)


I'm going to heavily quote [the Object documentation](http://ruby-doc.org/core/Object.html#method-i-eql-3F) here, because I think it has some great explanations. I encourage you to read it, and also the documentation for these methods as they're overridden in other classes, like [String](http://ruby-doc.org/core/classes/String.html).

*Side note: if you want to try these out for yourself on different objects, use something like this:*

```ruby
class Object
  def all_equals(o)
    ops = [:==, :===, :eql?, :equal?]
    Hash[ops.map(&:to_s).zip(ops.map {|s| send(s, o) })]
  end
end

"a".all_equals "a" # => {"=="=>true, "==="=>true, "eql?"=>true, "equal?"=>false}
```

---

## `==` — generic "equality"

> At the Object level, `==` returns true only if `obj` and `other` are the same object. Typically, this method is overridden in descendant classes to provide class-specific meaning.

This is the most common comparison, and thus the most fundamental place where you (as the author of a class) get to decide if two objects are "equal" or not.

## `===` — case equality

> For class Object, effectively the same as calling `#==`, but typically overridden by descendants to provide meaningful semantics in case statements.

This is incredibly useful. Examples of things which have interesting `===` implementations:

- Range
- Regex
- Proc (in Ruby 1.9)

So you can do things like:

```ruby
case some_object
when /a regex/
  # The regex matches
when 2..4
  # some_object is in the range 2..4
when lambda {|x| some_crazy_custom_predicate }
  # the lambda returned true
end
```

See [my answer here](https://stackoverflow.com/questions/1735717/help-refactoring-this-nasty-ruby-if-else-statement/1735777#1735777) for a neat example of how `case`+`Regex` can make code a lot cleaner. And of course, by providing your own `===` implementation, you can get custom `case` semantics.

## `eql?` — `Hash` equality

> The `eql?` method returns true if `obj` and `other` refer to the same hash key. This is used by `Hash` to test members for equality. **For objects of class Object, eql? is synonymous with ==**. Subclasses normally continue this tradition by aliasing `eql?` to their overridden `==` method, but there are exceptions. `Numeric` types, for example, perform type conversion across `==`, but not across `eql?`, so:
>
> ```ruby
> 1 == 1.0     #=> true
> 1.eql? 1.0   #=> false
> ```

So you're free to override this for your own uses, or you can override `==` and use `alias :eql? :==` so the two methods behave the same way.

## `equal?` — identity comparison

> Unlike `==`, the `equal?` method should never be overridden by subclasses: it is used to determine object identity (that is, `a.equal?(b)` iff `a` is the same object as `b`).

This is effectively pointer comparison.