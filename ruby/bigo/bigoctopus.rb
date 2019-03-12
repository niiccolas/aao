# Big O-ctopus and Biggest Fish
# A Very Hungry Octopus wants to eat the longest fish in an array of fish.
fishes = %w[fish fiiish fiiiiish fiiiish fffish ffiiiiisshh fsh fiiiissshhhhhh]

# Sluggish Octopus
# Finds the longest fish in O(n^2) quadratic time complexity
def sluggish_octopus(arr)
  longest_fish = ''
  arr.each do |fish1|
    arr.each do |fish2|
      longest_fish = fish1 if fish1.length > fish2.length
    end
  end
  longest_fish
end
p sluggish_octopus(fishes) # => "fiiiissshhhhhh"

# Dominant Octupus
# Finds the longest fish in O(n log n) log-linear time complexity
def dominant_octopus(arr)
  return nil if arr.empty?
  return arr if arr.length <= 1

  half      = arr.length / 2
  left_arr  = dominant_octopus(arr[0...half])
  right_arr = dominant_octopus(arr[half..-1])

  merge_arr(left_arr, right_arr)
end

def merge_arr(left, right)
  if left.empty?
    left
  elsif right.empty?
    right
  elsif left.first.length > right.first.length
    [left.first] + merge_arr(left[1..-1], right)
  else
    [right.first] + merge_arr(right[1..-1], left)
  end
end
p dominant_octopus(fishes) # => ["fiiiissshhhhhh"]

# Clever Octopus
# Finds the longest fish in O(n) linear time complexity.
def clever_octopus(arr)
  longest_fish = ''
  arr.each do |fish|
    longest_fish = fish if fish.length > longest_fish.length
  end
  longest_fish
end
p clever_octopus(fishes) # => "fiiiissshhhhhh"

# Dancing Octopus
# Full of fish, the Octopus attempts Dance Dance Revolution. To play the game, the octopus must step on a tile with her corresponding tentacle. We can assume that the octopus's eight tentacles are numbered and correspond to the tile direction indices.

# Slow Dance
# Given a tile direction, iterate through a tiles array to return the tentacle number (tile index) the octopus must move. This should take O(n) time.
def slow_dance(tile_direction, tiles)
  tiles.each_with_index do |tile, i|
    return i if tile == tile_direction
  end
end
tiles_array = %w[up right-up right right-down down left-down left  left-up]

p slow_dance('up', tiles_array) # => 0
p slow_dance('right-down', tiles_array) # => 3

# Constant Dance!
# Now that the octopus is warmed up, let's help her dance faster. Use a different data structure and write a new function so that you can access the tentacle number in O(1) time.
def fast_dance(tile_direction, tiles_hash)
  tiles_hash[tile_direction]
end
new_tiles_data_structure = {}
tiles_array.each_with_index { |tile, i| new_tiles_data_structure[tile] = i }

p fast_dance('up', new_tiles_data_structure) # => 0
p fast_dance('right-down', new_tiles_data_structure) # => 3
