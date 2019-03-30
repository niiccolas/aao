# Data Structures Walkthrough

[Video](https://vimeo.com/194131180)


### Solutions
```
# EASY

def range(arr)
  arr.max - arr.min
end

def in_order?(arr)
  arr.sort == arr
end


# MEDIUM

def num_vowels(str)
  str.downcase!
  str.count("a") + str.count("e") + str.count("i") + str.count("o") + str.count("u")
end

def devowel(str)
  # You'll learn how to define this more elegantly in the next chapter.
  str.delete!("a")
  str.delete!("A")
  str.delete!("e")
  str.delete!("E")
  str.delete!("i")
  str.delete!("I")
  str.delete!("o")
  str.delete!("O")
  str.delete!("u")
  str.delete!("U")
  str
end


# HARD

def descending_digits(int)
  # 1. convert the integer to a string
  # 2. split its characters
  # 3. sort the resulting array
  # 4. reverse the order
  int.to_s.chars.sort.reverse
end

def repeating_letters?(str)
  str.downcase.chars.uniq.length != str.length
end

def to_phone_number(arr)
  chunk_one = arr[0..2].join
  chunk_two = arr[3..5].join
  chunk_three = arr[6..9].join
  "(#{chunk_one}) #{chunk_two}-#{chunk_three}"
end

def str_range(str)
  arr = str.split(",")
  arr = arr.sort
  arr[-1].to_i - arr[0].to_i
end

#EXPERT

def my_rotate(arr, offset=1)
  split_idx = offset % arr.length
  arr.drop(split_idx) + arr.take(split_idx)
end
```