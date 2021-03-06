require_relative './plane.rb'
require_relative './weather.rb'

class Airport
  attr_reader :planes, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @planes = []
    @capacity = capacity
  end

  def land(plane, weather)
    check_weather(weather)
    raise 'Airport is full!' if airport_full?
    plane.land
    @planes.push(plane)
  end

  def takeoff(plane, weather)
    check_weather(weather)
    raise 'Plane isnt docked in airport' if no_plane?(plane)
    plane.takeoff
    @planes.delete(plane)
  end

  private

  def too_stormy?(weather)
    weather.stormy?
  end

  def airport_full?
    @planes.size >= DEFAULT_CAPACITY
  end

  def no_plane?(plane)
    !@planes.include? plane
  end

  def check_weather(weather)
    raise 'Its stormy!' if too_stormy?(weather)
  end
end
