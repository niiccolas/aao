# Big-O

The following is taken from a [Stack Overflow Question](https://stackoverflow.com/questions/487258/what-is-a-plain-english-explanation-of-big-o-notation) that requested a layman's explanation of Big O notation:

Quick note, this is almost certainly confusing [Big O notation](http://en.wikipedia.org/wiki/Big_O_notation) (which is an upper bound) with Theta notation (which is a two-side bound). In my experience this is actually typical of discussions in non-academic settings. Apologies for any confusion caused.

* * *

Big O complexity can be visualized with this graph:

![Big O Analysis](https://i.stack.imgur.com/WcBRI.png)

The simplest definition I can give for Big-O notation is this:

**Big-O notation is a relative representation of the complexity of an algorithm.**

There are some important and deliberately chosen words in that sentence:

> *   **relative:** you can only compare apples to apples. You can't compare an algorithm to do arithmetic multiplication to an algorithm that sorts a list of integers. But a comparison of two algorithms to do arithmetic operations (one multiplication, one addition) will tell you something meaningful;
> *   **representation:** Big-O (in its simplest form) reduces the comparison between algorithms to a single variable. That variable is chosen based on observations or assumptions. For example, sorting algorithms are typically compared based on comparison operations (comparing two nodes to determine their relative ordering). This assumes that comparison is expensive. But what if comparison is cheap but swapping is expensive? It changes the comparison; and
> *   **complexity:** if it takes me one second to sort 10,000 elements how long will it take me to sort one million? Complexity in this instance is a relative measure to something else.

Come back and reread the above when you've read the rest.

The best example of Big-O I can think of is doing arithmetic. Take two numbers (123456 and 789012). The basic arithmetic operations we learnt in school were:

> *   addition;
> *   subtraction;
> *   multiplication; and
> *   division.

Each of these is an operation or a problem. A method of solving these is called an **algorithm**.

Addition is the simplest. You line the numbers up (to the right) and add the digits in a column writing the last number of that addition in the result. The 'tens' part of that number is carried over to the next column.

Let's assume that the addition of these numbers is the most expensive operation in this algorithm. It stands to reason that to add these two numbers together we have to add together 6 digits (and possibly carry a 7th). If we add two 100 digit numbers together we have to do 100 additions. If we add **two** 10,000 digit numbers we have to do 10,000 additions.

See the pattern? The **complexity** (being the number of operations) is directly proportional to the number of digits _n_ in the larger number. We call this **O(n)** or **linear complexity**.

Subtraction is similar (except you may need to borrow instead of carry).

Multiplication is different. You line the numbers up, take the first digit in the bottom number and multiply it in turn against each digit in the top number and so on through each digit. So to multiply our two 6 digit numbers we must do 36 multiplications. We may need to do as many as 10 or 11 column adds to get the end result too.

If we have two 100-digit numbers we need to do 10,000 multiplications and 200 adds. For two one million digit numbers we need to do one trillion (10<sup>12</sup>) multiplications and two million adds.

As the algorithm scales with n-_squared_, this is **O(n<sup>2</sup>)** or **quadratic complexity**. This is a good time to introduce another important concept:

**We only care about the most significant portion of complexity.**

The astute may have realized that we could express the number of operations as: n<sup>2</sup> + 2n. But as you saw from our example with two numbers of a million digits apiece, the second term (2n) becomes insignificant (accounting for 0.0002% of the total operations by that stage).

One can notice that we've assumed the worst case scenario here. While multiplying 6 digit numbers if one of them is 4 digit and the other one is 6 digit, then we only have 24 multiplications. Still we calculate the worst case scenario for that 'n', i.e when both are 6 digit numbers. Hence Big-O notation is about the Worst-case scenario of an algorithm

# The Telephone Book

The next best example I can think of is the telephone book, normally called the White Pages or similar but it'll vary from country to country. But I'm talking about the one that lists people by surname and then initials or first name, possibly address and then telephone numbers.

Now if you were instructing a computer to look up the phone number for "John Smith" in a telephone book that contains 1,000,000 names, what would you do? Ignoring the fact that you could guess how far in the S's started (let's assume you can't), what would you do?

A typical implementation might be to open up to the middle, take the 500,000<sup>th</sup> and compare it to "Smith". If it happens to be "Smith, John", we just got real lucky. Far more likely is that "John Smith" will be before or after that name. If it's after we then divide the last half of the phone book in half and repeat. If it's before then we divide the first half of the phone book in half and repeat. And so on.

This is called a **binary search** and is used every day in programming whether you realize it or not.

So if you want to find a name in a phone book of a million names you can actually find any name by doing this at most 20 times. In comparing search algorithms we decide that this comparison is our 'n'.

> *   For a phone book of 3 names it takes 2 comparisons (at most).
> *   For 7 it takes at most 3.
> *   For 15 it takes 4.
> *   …
> *   For 1,000,000 it takes 20.

That is staggeringly good isn't it?

In Big-O terms this is **O(log n)** or **logarithmic complexity**. Now the logarithm in question could be ln (base e), log<sub>10</sub>, log<sub>2</sub> or some other base. It doesn't matter it's still O(log n) just like O(2n<sup>2</sup>) and O(100n<sup>2</sup>) are still both O(n<sup>2</sup>).

It's worthwhile at this point to explain that Big O can be used to determine three cases with an algorithm:

> *   **Best Case:** In the telephone book search, the best case is that we find the name in one comparison. This is **O(1)** or **constant complexity**;
> *   **Expected Case:** As discussed above this is O(log n); and
> *   **Worst Case:** This is also O(log n).

Normally we don't care about the best case. We're interested in the expected and worst case. Sometimes one or the other of these will be more important.

Back to the telephone book.

What if you have a phone number and want to find a name? The police have a reverse phone book but such look-ups are denied to the general public. Or are they? Technically you can reverse look-up a number in an ordinary phone book. How?

You start at the first name and compare the number. If it's a match, great, if not, you move on to the next. You have to do it this way because the phone book is **unordered** (by phone number anyway).

So to find a name given the phone number (reverse lookup):

> *   **Best Case:** O(1);
> *   **Expected Case:** O(n) (for 500,000); and
> *   **Worst Case:** O(n) (for 1,000,000).

# The Travelling Salesman

This is quite a famous problem in computer science and deserves a mention. In this problem you have N towns. Each of those towns is linked to 1 or more other towns by a road of a certain distance. The Travelling Salesman problem is to find the shortest tour that visits every town.

Sounds simple? Think again.

If you have 3 towns A, B and C with roads between all pairs then you could go:

> *   A → B → C
> *   A → C → B
> *   B → C → A
> *   B → A → C
> *   C → A → B
> *   C → B → A

Well actually there's less than that because some of these are equivalent (A → B → C and C → B → A are equivalent, for example, because they use the same roads, just in reverse).

In actuality there are 3 possibilities.

> *   Take this to 4 towns and you have (iirc) 12 possibilities.
> *   With 5 it's 60.
> *   6 becomes 360.

This is a function of a mathematical operation called a **factorial**. Basically:

> *   5! = 5 × 4 × 3 × 2 × 1 = 120
> *   6! = 6 × 5 × 4 × 3 × 2 × 1 = 720
> *   7! = 7 × 6 × 5 × 4 × 3 × 2 × 1 = 5040
> *   …
> *   25! = 25 × 24 × … × 2 × 1 = 15,511,210,043,330,985,984,000,000
> *   …
> *   50! = 50 × 49 × … × 2 × 1 = 3.04140932 × 10<sup>64</sup>

So the Big-O of the Travelling Salesman problem is **O(n!)** or **factorial or combinatorial complexity**.

**By the time you get to 200 towns there isn't enough time left in the universe to solve the problem with traditional computers.**

Something to think about.

# Polynomial Time

Another point I wanted to make quick mention of is that any algorithm that has a complexity of **O(n<sup>a</sup>)** is said to have **polynomial complexity** or is solvable in **polynomial time**.

O(n), O(n<sup>2</sup>) etc are all polynomial time. Some problems cannot be solved in polynomial time. Certain things are used in the world because of this. Public Key Cryptography is a prime example. It is computationally hard to find two prime factors of a very large number. If it wasn't, we couldn't use the public key systems we use.

Anyway, that's it for my (hopefully plain English) explanation of Big O (revised).

## Big-O Complexity Chart

![big-O-complexity-chart](big-O-complexity-chart.png)

![array-sorting-algorithms](array-sorting-algorithms.png)

![common-data-structure-operations](common-data-structure-operations.png)

## Algorithm Animations

* [Merge Sort Animation](http://www.algomation.com/player?algorithm=551321f6e1b6fa0300aae4d0)
* [Bubble Sort Animation](http://www.algomation.com/player?algorithm=541a6ea7a7fe980200089c5e)

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


<!-- ### Projects:
* []()
* []()
* []() -->