# Walkthrough 2

[Video](https://player.vimeo.com/video/196824799?rel=0&amp;autoplay=1)

## Solutions

    def array_sum(arr)
      arr.reduce(:+)
    end

    def in_all_strings?(long_strings, substring)
      long_strings.all? {|string| string.include?(substring)}
    end

    def non_unique_letters(string)
      characters = string.chars.uniq
      characters.delete(" ") # get rid of spaces!

      characters.select {|char| string.count(char) > 1}
    end

    def longest_two_words(string)
      string.delete!(",.;:!?")
      string.split.sort_by {|word| word.length}[-2..-1]
    end

    # MEDIUM

    def missing_letters(string)
      alphabet = ("a".."z")
      alphabet.reject do |el|
        string.downcase.include?(el)
      end
    end

    def no_repeat_years(first_yr, last_yr)
      (first_yr..last_yr).select do |year|
        no_repeat_year?(year)
      end
    end

    def no_repeat_year?(year)
      year_digits = year.to_s.chars
      year_digits == year_digits.uniq
    end

    # HARD

    def one_week_wonders(songs)
      uniq_songs = songs.uniq
      uniq_songs.select do |song|
        no_repeats?(song, songs)
      end
    end

    def no_repeats?(song_name, songs)
      songs.each_with_index do |song, idx|
        if song == song_name
          return false if song == songs[idx + 1]
        end
      end

      true
    end

    def for_cs_sake(string)
      remove_punctuation(string)
      c_words = string.split.select { |word| word.downcase.include?("c") }
      return "" if c_words.empty?
      c_words.sort_by { |word| c_distance(word) }.first
    end

    def c_distance(word)
      word.reverse.index("c")
    end

    def remove_punctuation(string)
      string.delete!(",.;:!?")
    end

    def repeated_number_ranges(numbers)
      ranges = []
      start_index = nil

      # start walking
      # set the start_index when we're at the beginning of a range
      # when we reach the end of a range, add the range to the list and reset the start_index

      numbers.each_with_index do |el, idx|
        next_el = numbers[idx + 1]
        if el == next_el
          start_index = idx unless start_index #i.e., reset the start_index if it's nil
        elsif start_index # i.e., if the start index isn't nil (the numbers switched)
          ranges.push([start_index, idx])
          start_index = nil # reset the start_index to nil so we can capture more ranges
        end
      end

      ranges
    end

