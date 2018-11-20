def factors(int)
  raise if int.nil?
  (1...int).select { |factor| (int % factor).zero? }
end

class Array
  def bubble_sort!(&prc)
    prc || prc = Proc.new { |x, y| x <=> y } # in case no prc/block is supplied
    # Alt. syntax: prc ||= Proc.new { |x, y| x <=> y }
    # https://stackoverflow.com/questions/995593/what-does-or-equals-mean-in-ruby

    (self.length - 1).times do
      self.each_with_index do |current, idx, previous = self[idx - 1]|
        next if idx.zero? # skip index 0, start iteration at index 1

        if prc.call(current, previous) == -1 # if descending order
          self[idx - 1], self[idx] = self[idx], self[idx - 1] # swap/sort
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.clone.bubble_sort!(&prc)
  end

end

def substrings(string)
  substrings_array = []

  string.chars.each_with_index do |_char, idx1|
    (idx1...string.length).each do |idx2|
      substrings_array << string[idx1..idx2]
    end
  end

  substrings_array
end

def subwords(string, dictionary)
  substrings(string).select { |word| dictionary.include? word }.uniq
end

p subwords("seassoucat..sdqfoamazeazecat", ["cat","sea","foam"])
p substrings("foam")
p substrings("")

# p ["c", "a", "t"].slice(0, 1).join
# p "cat".slice(0, 2)
# p "cat".slice(0, 3)

# p "cat".unshift