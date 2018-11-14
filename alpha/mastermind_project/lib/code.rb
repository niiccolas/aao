# :nodoc:
class Code
  POSSIBLE_PEGS = {
    'R' => :red,
    'G' => :green,
    'B' => :blue,
    'Y' => :yellow
  }.freeze

  def self.valid_pegs?(pegs_arr)
    pegs_arr.all? { |el| POSSIBLE_PEGS.include?(el.upcase) }
  end

  def initialize(pegs_arr)
    raise 'ERROR: Invalid pegs!' unless Code.valid_pegs?(pegs_arr)

    @pegs = pegs_arr.map(&:upcase)
  end

  attr_reader :pegs

  def self.random(length)
    random_pegs = []
    length.times { random_pegs << POSSIBLE_PEGS.keys.sample }
    Code.new(random_pegs)
  end

  def self.from_string(pegs_str)
    Code.new(pegs_str.chars)
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(code_instance)
    matches = 0
    code_instance.pegs.each_index do |idx|
      matches += 1 if code_instance[idx] == @pegs[idx]
    end
    matches
  end

  def num_near_matches(code_instance)
    matches = 0
    code_instance.pegs.each_with_index do |elem, idx|
      matches += 1 if code_instance[idx] != @pegs[idx] && @pegs.include?(elem)
    end
    matches
  end

  def ==(other)
    @pegs == other.pegs
  end
end
