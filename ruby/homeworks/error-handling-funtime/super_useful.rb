# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError => err
  puts err.message
end

# PHASE 3
FRUITS = ['apple', 'banana', 'orange'].freeze

class CoffeeError < StandardError
  def message
    "I love coffee! Here, I'll let you try again."
  end
end

class NotAFruitError < StandardError
  def message
    'This is not a fruit I know, I should go now.'
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee'
    raise CoffeeError
  else
    raise NotAFruitError
  end
end

def feed_me_a_fruit
  puts 'Hello, I am a friendly monster. :)'

  puts 'Feed me a fruit! (Enter the name of a fruit:)'
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
rescue CoffeeError => e
  puts e.message
  retry # if it's a CoffeeError, he's willing to let us retry
rescue NotAFruitError => e
  puts e.message
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


