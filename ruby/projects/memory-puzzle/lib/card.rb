class Card
  ALPHABET = ('A'..'Z').to_a

  attr_reader :value

  def self.shuffled_pairs(num_pairs)
    alphabet = ALPHABET

    # If we require more than 26 pairs,
    # double the content of the alphabet as needed
    while num_pairs > alphabet.length
      alphabet = alphabet + alphabet
    end

    values = alphabet.shuffle.take(num_pairs) * 2
    values.shuffle!
    values.map { |value| self.new(value) }
  end

  def initialize(value, face_up = false)
    @value   = value
    @face_up = face_up
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    revealed? ? @value.to_s : " "
  end

  def revealed?
    @face_up
  end

  def ==(other)
    other.is_a?(self.class) && other.value == @value
  end
end
