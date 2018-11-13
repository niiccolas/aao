# :nodoc:
class Room
  def initialize(capacity)
    @capacity  = capacity
    @occupants = []
  end

  attr_reader :capacity
  attr_reader :occupants

  def full?
    return false if occupants.count < capacity

    true
  end

  def available_space
    capacity - occupants.count
  end

  def add_occupant(occupant)
    unless full?
      occupants << occupant
      return true
    end
    false
  end
end
