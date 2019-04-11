# Walkthrough 1

[Video](https://player.vimeo.com/video/196824370?rel=0&amp;autoplay=1)

## Solutions

    # EASY

    def get_evens(arr)
      arr.select { |element| element.even? }
    end

    def calculate_doubles(arr)
      arr.map {|el| el * 2}
    end

    def calculate_doubles!(arr)
      arr.map! {|el| el * 2}
    end

    def array_sum_with_index(arr)
      sum = 0

      arr.each_with_index do |number, index|
        sum += (number * index )
      end

      sum
    end

    # MEDIUM

    def price_is_right(bids, actual_retail_price)
      lower_bids = bids.reject { |bid| bid > actual_retail_price}
      lower_bids.max
    end

    def at_least_n_factors(numbers, n)
      numbers.select { |number| num_factors(number) >= n }
    end

    def num_factors(number)
      (1..number).count { |n| number % n == 0 }
    end

    # HARD

    def ordered_vowel_words(words)
      words.select do |word|
        ordered_vowel_word?(word)
      end
    end

    def ordered_vowel_word?(word)
      vowels = "aeiou"

      vowels_in_word = word.chars.select do |letter|
        vowels.include?(letter)
      end

      vowels_in_word == vowels_in_word.sort
    end

    def products_except_me(numbers)
      numbers.map.with_index do |num, idx|
        sub_array = numbers[0...idx] + numbers[(idx + 1)..-1]
        array_product(sub_array)
      end
    end

    def array_product(array)
      array.reduce(:*)
    end

