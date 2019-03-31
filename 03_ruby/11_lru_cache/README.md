# How the Hash Works in Ruby

[source](https://launchschool.com/blog/how-the-hash-works-in-ruby) 


A brief overview of the hash data structure, how it is implemented in Ruby and a peek at the history of changes made to the hash in MRI Ruby.

## What is a Hash?

A Hash is a data structure that organizes data in key-value pairs. It is also referred to as a dictionary or associative array. It stores these key-value pairs of associated data in a way that enables efficient insertion and lookup, in constant O(1) time. These properties of a hash make it is one of the most useful tools in a programmer’s toolbox and it is available in the core libraries of most if not all, programming languages.

In Ruby a hash can be declared literally as



```
`h = {color: "black", font: "Monaco"} h = {:color=>"black", :font=>"Monaco"} `
```

or declaratively with the new method



```
`h = Hash.new h[:color] = "black" h[:font] = "Monoco" `
```

## How does a Hash store data and why is it efficient?

To understand how data is stored in a hash and why it is efficient, let’s revisit the basic linear data structure, the *array*. An array allows us to randomly access any element that it stores if we know the index of that element beforehand.



```
`a = [1,2,4,5] puts a[2]  #> 4 `
```

If the key-value pairs we were trying to store were integers within a limited range such as 1-20 or 1-100, we would simply use an array and our key would be the integer.

For example, given that

- we need to store the names of the students in a classroom with 20 students
- each student has a student id between 1 and 20
- no two students have the same student id.

We could simply store their names represented by the table below in an array

| Key  | Value        |
| :--- | :----------- |
| 1    | Belle        |
| 2    | Ariel        |
| 3    | Peter Pan    |
| 4    | Mickey Mouse |



```
`students= ['Belle', 'Ariel', 'Peter Pan', 'Mickey Mouse'] `
```

But, what if the student id was a 4-digit number? Then we would have to assign a 10000 element table to access the names by the id. To solve this we simplify the key to the last 2 digits of the 4 digit number and use that as the location inside the table, so we can get random access to the record. Now, if we have another student with id “3221”, also ending in “21”, we would have to save two values at that location resulting in a collision.

| Key        | Hash(key) = last 2 digits | Value        |
| :--------- | :------------------------ | :----------- |
| 4221, 3221 | 21                        | Belle, Sofia |
| 1357       | 57                        | Ariel        |
| 4612       | 12                        | Peter Pan    |
| 1514       | 14                        | Mickey Mouse |



```
`students= Array.new(100) students[21]=['Belle','Sofia'] students[57]='Ariel' students[12]='Peter Pan' students[14]='Mickey Mouse' `
```

What if the id was a 10-digit number or an alphanumeric string? This gets inefficient and unwieldy quickly. Unfortunately, too simple a hashing strategy can lead to problems.

## How Ruby’s hash function works

So, now we have an understanding that the purpose of a hash function is to convert a given a key into an integer of limited range. In order to reduce the range, a commonly used technique is the *division method*. In the division method, the key is divided by the size of the storage or table and the remainder is the location inside that table where a record can be stored. Therefore, in the example above, if the table size was 20, the locations would be 1, 17, 12, 14 derived from the computation below.

- `4221 % 20 = 1`
- `1357 % 20 = 17`
- `4612 % 20 = 12`
- `1514 % 20 = 14`

But in real life programming the keys are not always nice integers, they are strings, objects, or some other data type. This is solved by using a one-way hash function(digest) over the key and then applying the division method to get the location. The *hash function* is a mathematical function that takes a string of any length and produces a fixed length integer value. The hash data structure derives it’s name from this hashing mechanism. Ruby uses the [murmur hash function](http://en.wikipedia.org/wiki/MurmurHash) and then applies the division method with a prime number M, which Ruby determines based on the table size that is needed for storage.

```
murmur_hash(key) % M
```

The code for this can be found in Ruby language’s source code in [st.c file](https://github.com/ruby/ruby/blob/1b5acebef2d447a3dbed6cf5e146fda74b81f10d/st.c).

In case two keys return the same number, also known as a *hash collision*, the value is chained on to the same location or bucket in the table.

## How Ruby handles hash collisons and growth

One of the problems faced by hash functions is distribution. What if most remainders fall into the same bucket? We would have to first find the bucket in the table from computing over the key, and then look through all the chained data in the location to find the matching record. That would defeat the purpose of creating a hash data structure for random access and O(1) time, because now we have to iterate over all these values to find the record which puts us back to O(n) time.

It has been found that if divisor M is prime, the results are not as biased and more evenly distributed. But, even with the best divisor, collisions will occur as the number of records being added increases. Ruby adjusts the value of M based the *density*. Density is the number of records chained at a location in the table. In the above example, the density is *2*, since we have 2 records that have the index/location 1.

Ruby sets the maximum allowed density value to 5.



```
`#define ST_DEFAULT_MAX_DENSITY 5 `
```

When the density of the records reaches 5, then Ruby adjusts the value of M, re-computes and adjust the hash for all the records that are in that hash. “The algorithm that computes M is one that generates prime numbers near powers of 2”, from [Data Structures using C](http://www.amazon.com/Data-Structures-Using-Aaron-Tenenbaum/dp/0131997467). Look at the function new_size in [st.c](https://github.com/ruby/ruby/blob/1b5acebef2d447a3dbed6cf5e146fda74b81f10d/st.c) at line 158. This is where the size of the new hash is computed.



```
`new_size(st_index_t size) {     st_index_t i;     for (i=3; i<31; i++) {       if ((st_index_t)(1<<i) > size) return 1<<i;     }     return -1; } `
```

This is easier to read in the [JRuby’s](https://github.com/jruby/jruby/blob/master/core/src/main/java/org/jruby/RubyHash.java) implementation of Hash where the prepared prime number values are statically used from an int array. As you can see the next values are 11, 19 and so on.



```
`private static final int MRI_PRIMES[] = { 8 + 3, 16 + 3, 32 + 5, 64 + 3, 128 + 3, 256 + 27, ....}; `
```

This *rehashing* as the data grows larger causes a spike in the performance when the hash reaches certain specific sizes. Pat Shaughnessy does a detailed analysis of this in [Ruby under a Microscope](http://patshaughnessy.net/ruby-under-a-microscope) and graphs the data so you can see the spikes that occur when rehashing happens.

## Ruby hashes are unique for each process

One interesting thing to note is hashes are unique for each Ruby process. The murmur hash seeds it with a random value, which results in a different hash for a particular key for each Ruby process.

## Ruby has packed hashes for up to 6 entries since Ruby 2.0

Another interesting thing to note is that Ruby hashes that are very small(less than or equal to 6) are saved in one bucket and not spread over several buckets based on computed hash of the key. Instead, they are simply an array of values. This was added recently and is referred to as a packed entry in the code in st.c. On the [pull request](https://github.com/ruby/ruby/pull/84) in which this change was submitted, the commiter has made the following comment.

￼ “Investigation shows, that typical rails application allocates tons of small hashes. Up to￼40% of whole allocated hashes never grows bigger than 1 element size.”

## Ruby hash keys are ordered

Starting with Ruby 1.9.3, a property of the hash is that the keys are ordered based on how they are inserted into the hash. An interesting question was posted on the [Ruby-forum](https://www.ruby-forum.com/topic/166075) questioning the reasoning behind it and how it would effect performance. The reply by [Matz](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto), creator of Ruby, on that thread, which explains the change is below.

*Could anybody explain why this feature was added?*

“Useful for some cases, especially for keyword arguments.”

*Isn’t it going to slow down the operations on the Hash?*

“No. hash reference operation does not touch order information, only for iteration. Memory consumption increased a bit.”

Note: Keyword arguments were added to Ruby in 2.0, and an example is below



```
`def books(title: 'Programming Ruby')   puts title end  books # => 'Programming Ruby' books(title: 'Eloquent Ruby') # => 'Eloquent Ruby' `
```

## Two potential upcoming changes in Hash

1) The next version of Ruby, will most likely introduce syntax sugar for a literal declaration of the hash that will allow spaces in symbols. Take a look at this commit on [ruby-trunk](https://bugs.ruby-lang.org/issues/4276). You may recall, that the first change from hashrocket to colon was introduced in Ruby 1.9 bringing the syntax closer to JSON’s syntax. With this upcoming change the hash will looks even more so like [JSON](http://en.wikipedia.org/wiki/JSON).

Currently we need to declare a symbol with a space using a hash rocket



```
`  h = {:"a perfect color" => "vermilion"} #=> {:"a perfect color"=>"vermilion"} `
```

With the change it will simply be the symbol within quotes followed by a colon.



```
`h = {"a perfect color": "vermilion"} `
```

2) Another interesting change that is in the works is a method that will allow returning [default values for missing keys in a hash](https://bugs.ruby-lang.org/issues/10017).

Currently you can return the default value of only one key using `hash.fetch`, however the `hash.values_at`method allows returning multiple values for keys



```
`h = {color: "black", font: "monaco"} h.fetch(:fontsize, "12pt") #=> "12pt" h.values_at(:color, :font) #=> ["black", "monaco"] `
```

The change proposed is to combine these two methods into one. It might work something like the `fetch_values` method shown below. Please note the new method name is still being voted on and the example is hypothetical.



```
`h.fetch_values(:color, :font, :fontsize, :border) do |k| k == "fontsize" ? "12pt" : "#{k} is missing" end #=> ["black", "monaco", "12pt", "border is missing"] `
```

## Conclusion

Data structures are universal. A hash is essentially the same, whether it’s implemented in Java, Python or Ruby. Hopefully, having this perspective enables us to look beyond just being users of the hash API, provides better understanding about the efficiency of the code we are writing and even contributing to improve the next release of Ruby.

## References/resources

1. [Data Structures using C](http://www.amazon.com/Data-Structures-Using-Aaron-Tenenbaum/dp/0131997467)
2. [Ruby Under a Microscope](http://patshaughnessy.net/ruby-under-a-microscope)
3. [st.c](https://github.com/ruby/ruby/blob/1b5acebef2d447a3dbed6cf5e146fda74b81f10d/st.c)
4. [RubyHash.java](https://github.com/jruby/jruby/blob/master/core/src/main/java/org/jruby/RubyHash.java)