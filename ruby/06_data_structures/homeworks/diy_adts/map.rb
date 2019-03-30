class Map # aka. Dictionary
  def initialize
    @map_array = []
  end

  def set(key, value)
    unique_key =  @map_array.none? { |kvpair| kvpair.include?(key) }
    if unique_key
      @map_array << [key, value]
    else
      @map_array.each_with_index do |kvpair, i|
        if kvpair.first == key
          @map_array[i] = [key, value]
        end
      end
    end

    value
  end

  def get(key)
    @map_array.each do |pair|
      return pair[1] if key == pair[0]
    end
  end

  def delete(key)
    @map_array.each_with_index do |pair, i|
      if pair[0] == key
        @map_array.delete_at(i)
        return pair[1]
      end
    end
  end

  def show
    @map_array
  end
end
