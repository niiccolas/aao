# Echoes a string
def echo(str)
  str
end

# Upcase a string
def shout(str)
  str.upcase
end

# Repeat a string n times, 1 repeat by default
def repeat(str, num = 2)
  ([str] * num).join(' ')
end

# Returns the n first letters of a string
def start_of_word(str, num)
  str[0...num]
end

# Returns the first word of a string
def first_word(str)
  str.split(' ')[0]
end

# Capitalize every word of a string,
# except for "little" words such as "and", "the", "over"
def titleize(str)
  little_words = %w(and over the)
  str.split(' ').map.with_index do |word, idx|
    if (little_words.include? word) && (idx != 0)
      word
    else
      word[0].upcase + word[1..-1]
    end
  end.join(' ')
end