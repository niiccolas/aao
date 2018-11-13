require_relative 'room'

# :nodoc:
class Hotel
  def initialize(hotel_name, room)
    @name = hotel_name
    @rooms = {}
    room.each do |room_name, capacity|
      rooms[room_name] = Room.new(capacity)
    end
  end

  attr_accessor :rooms

  def name
    @name.split.map(&:capitalize).join(' ')
  end

  def room_exists?(room)
    return true if rooms.key?(room)

    false
  end

  def check_in(person, room)
    if room_exists?(room)
      if rooms[room].add_occupant(person)
        puts 'check in successful'
      else
        puts 'sorry, room is full'
      end
    else
      puts 'sorry, room does not exist'
    end
  end

  def has_vacancy?
    rooms.values.any? { |room| room.available_space > 0 }
  end

  def list_rooms
    rooms.each do |room_name, room|
      puts "#{room_name}.*#{room.available_space}"
    end
  end
end
