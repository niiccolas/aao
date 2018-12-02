class Card
  VALUES = ('A'..'Z')

  def self.shuffled_pairs(num_pairs, face_up = false)
    shuffled_pairs = []

    num_pairs.times do
      random_value = VALUES.to_a.sample
      num_pairs.times do
        shuffled_pairs << Card.new(random_value, face_up)
      end
    end

    shuffled_pairs.shuffle!
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
    @face_up ? @value.to_s : ' '
  end

  def revealed?
    @face_up
  end

  def ==(other)
    other.is_a?(self.class) && other.value == @value
  end
end
