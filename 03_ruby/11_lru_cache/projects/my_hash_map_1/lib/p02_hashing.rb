class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    each_with_index.inject(0) do |temp_hash, (el, i)|
      (el.hash + i.hash) ^ temp_hash
    end
    # map(&:ord).join.to_i.hash
  end
end

class String
  def hash
    # chars.hash.hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    flatten.map(&:to_s).map(&:ord).sort.join.to_i
  end
end




# [2,3,4].each_with_index.inject(0) do |interm, (e, i)|
#   e ^ interm
# end