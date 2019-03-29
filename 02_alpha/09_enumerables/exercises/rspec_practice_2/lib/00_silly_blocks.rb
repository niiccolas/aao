def reverser(&prc)
  from_the_block = prc.call
  from_the_block.split(' ').map(&:reverse).join(' ')
end

# puts reverser { 'thunderer'}  # => 'rerednuht'
# puts reverser { 'home fleet'} # => 'emoh teelf'

def adder(num = 1, &prc)
  prc.call + num
end

# puts adder { 15 }     # => 16
# puts adder(10) { 15 } # => 25

def repeater(num = 1, &prc)
  num.times { puts prc.call }
end

# puts repeater(25) { 'I will not bribe Principal Skinner' }