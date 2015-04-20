class Garage
  attr_reader :capacity, :bikes
  def initialize
    @capacity = 25
    @bikes = []
  end

  def dock(bike, from_van)
    @bikes << bike
    from_van.bikes.delete(bike)
  end

  def release(bike, to_van)
    @bikes.delete(bike)
    to_van.bikes << bike
  end

  def fix_a_bike(bike)
    # I made the same mistake as last time. trying to have bike.working = true
    # the state of bike can only change IN BIKE !!!
    # the solution is simply to call he fix! method from bike there.
    bike.fix!
  end
end
