# Helper methods
def vowel?(char)
  # 'u' removed to account for 'qu' phoneme
  'aeio'.include? char.downcase
end

def piglatinize(word)
  word.each_char.with_index do |char, idx|
    # Select from idx of vowel to end of word...
    # + chars preceding the vowel, if any...
    # + 'ay'
    return word[idx..-1] + word[0...idx] + 'ay' if vowel?(char)
  end
end

# Translate method, plugged with the helper ones
def translate(str)
  str.split(' ').map { |word| piglatinize(word) }.join(' ')
end
