# Big O Notation

## Using not-boring math to measure code's efficiency
### The idea behind big O notation

**Big O notation is the language we use for talking about how long an algorithm takes to run**. It's how we compare the efficiency of different approaches to a problem.

It's like math except it's an **awesome, not-boring kind of math** where you get to wave your hands through the details and just focus on what's _basically_ happening.

With big O notation we express the runtime in terms of—brace yourself—_how quickly it grows relative to the input, as the input gets arbitrarily large_.

Let's break that down:

1.  **how quickly the runtime grows**—It's hard to pin down the _exact runtime_ of an algorithm. It depends on the speed of the processor, what else the computer is running, etc. So instead of talking about the runtime directly, we use big O notation to talk about _how quickly the runtime grows_.

2.  **relative to the input**—If we were measuring our runtime directly, we could express our speed in seconds. Since we're measuring _how quickly our runtime grows_, we need to express our speed in terms of...something else. With Big O notation, we use the size of the input, which we call "n." So we can say things like the runtime grows "on the order of the size of the input" (O(n)) or "on the order of the square of the size of the input" (O(N^2)).

3. **as the input gets arbitrarily large** - Our algorithm may have steps that seem expensive when nn is small but are eclipsed eventually by other steps as nn gets huge. For big O analysis, we care most about the stuff that grows fastest as the input grows, because everything else is quickly eclipsed as nn gets very large. (If you know what an asymptote is, you might see why "big O analysis" is sometimes called "asymptotic analysis.")

If this seems abstract so far, that's because it is. Let's look at some examples.

## Some examples

```
def print_first_item(items)
  puts items[0]
end
```
This method runs in O(1) time (or "constant time") relative to its input. The input array could be 1 item or 1,000 items, but this method would still just require one "step."

```
  def print_all_items(items)
  items.each do |item|
    puts item
  end
end
```

This method runs in O(n) time (or "linear time"), where nn is the number of items in the array. If the array has 10 items, we have to print 10 times. If it has 1,000 items, we have to print 1,000 times.

```
  def print_all_possible_ordered_pairs(items)
  items.each do |first_item|
    items.each do |second_item|
      puts first_item, second_item
    end
  end
end
```
Here we're nesting two loops. If our array has nn items, our outer loop runs n times and our inner loop runs n times for each iteration of the outer loop, giving us n^2 total prints. Thus this method runs in O(n^2) time (or "quadratic time"). If the array has 10 items, we have to print 100 times. If it has 1,000 items, we have to print 1,000,000 times.

## N could be the actual input, or the size of the input

Both of these methods have O(n) runtime, even though one takes an integer as its input and the other takes an array:

```
def say_hi_n_times(n)
  n.times { puts "hi" }
end

def print_all_items(items)
  items.each do |item|
    puts item
  end
end
```

So sometimes n is an actual number that's an input to our method, and other times nn is the number of items in an input array (or an input map, or an input object, etc.).

## Drop the constants

This is why big O notation rules. When you're calculating the big O complexity of something, you just throw out the constants. So like:
```
def print_all_items_twice(items)
  items.each do |item|
    puts item
  end

  # once more, with feeling
  items.each do |item|
    puts item
  end
end
```

This is O (2n)O(2n), which we just call O(n).
```
def print_first_item_then_first_half_then_say_hi_100_times(items)
  puts items[0]

  middle_index = items.length / 2
  index = 0

  while index < middle_index
    puts items[index]
    index += 1
  end

  100.times do { puts "hi" }
end
```
This isO(1+n/2+100), which we just call O(n).

Why can we get away with this? Remember, for big O notation we're looking at what happens as nn gets arbitrarily large. As nn gets really big, adding 100 or dividing by 2 has a decreasingly significant effect.

## Drop the less significant terms

For example:
```
def print_all_numbers_then_all_pair_sums(numbers)

  puts "these are the numbers:"
  numbers.each do |number|
    puts number
  end

  puts "and these are their sums:"
  numbers.each do |first_number|
    numbers.each do |second_number|
      puts first_number + second_number
    end
  end
end
```
Here our runtime is O(n+n^2), which we just call O(n^​2). Even if it was O(n^2/2+100n), it would still be O(N^2).

Similarly:

* O(n^3+50n+2+10000) is O(N^3)
* O((n+30)∗(n+5)) is O(N^2)

Again, we can get away with this because the less significant terms quickly become, well, less significant as nn gets big.

## We're usually talking about the "worst case"

Often this "worst case" stipulation is implied. But sometimes you can impress your interviewer by saying it explicitly.

Sometimes the worst case runtime is significantly worse than the best case runtime:
```
  def contains(haystack, needle)

  # does the haystack contain the needle?
  haystack.each do |value|
    return true if value == needle
  end

  false
end
```
Here we might have 100 items in our haystack, but the first item might be the needle, in which case we would return in just 1 iteration of our loop.

In general we'd say this is O(n) runtime and the "worst case" part would be implied. But to be more specific we could say this is worst case O(n) and best case O(1) runtime. For some algorithms we can also make rigorous statements about the "average case" runtime.

## Space complexity: the final frontier

Sometimes we want to optimize for using less memory instead of (or in addition to) using less time. Talking about memory cost (or "space complexity") is very similar to talking about time cost. We simply look at the total size (relative to the size of the input) of any new variables we're allocating.

This method takes O(1) space (we use a fixed number of variables):
```
def say_hi_n_times(n)
  n.times { puts "hi" }
end
```
This method takes O(n) space (the size of hi_array scales with the size of the input):
```
def array_of_hi_n_times(n)
  hi_array = []
  n.times { hi_array.push("hi") }
  hi_array
end
```

Usually when we talk about space complexity, we're talking about additional space, so we don't include space taken up by the inputs. For example, this method takes constant space even though the input has nn items:

```
class Integer
  N_BYTES = [1].pack('i').size
  N_BITS = N_BYTES * 16
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1
end

def get_largest_item(items)
  largest = Integer::MIN
  items.each do |item|
    if item > largest
      largest = item
    end
  end
  largest
end
```

**Sometimes there's a tradeoff between saving time and saving space**, so you have to decide which one you're optimizing for.

## Big O analysis is awesome except when it's not

You should make a habit of thinking about the time and space complexity of algorithms _as you design them_. Before long this'll become second nature, allowing you to see optimizations and potential performance issues right away.

Asymptotic analysis is a powerful tool, but wield it wisely.

Big O ignores constants, but **sometimes the constants matter**. If we have a script that takes 5 hours to run, an optimization that divides the runtime by 5 might not affect big O, but it still saves you 4 hours of waiting.

**Beware of premature optimization**. Sometimes optimizing time or space negatively impacts readability or coding time. For a young startup it might be more important to write code that's easy to ship quickly or easy to understand later, even if this means it's less time and space efficient than it could be.

But that doesn't mean startups don't care about big O analysis. A great engineer (startup or otherwise) knows how to strike the right _balance_ between runtime, space, implementation time, maintainability, and readability.

**You should develop the _skill_ to see time and space optimizations, as well as the _wisdom_ to judge if those optimizations are worthwhile.**
