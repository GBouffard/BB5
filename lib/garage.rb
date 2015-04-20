class Garage
  attr_reader :capacity, :bikes
  def initialize(cap = 25)
    @capacity = cap
    @bikes = []
  end

  def dock(bike, from_van)
    if @bikes.length == @capacity
      fail 'This garage is full'
    else
      @bikes << bike
      from_van.bikes.delete(bike)
    end
  end

  def release(bike, to_van)
    if @bikes == []
      fail 'There is no bike to release'
    else
      @bikes.delete(bike)
      to_van.bikes << bike
    end
  end

  def fix_a_bike(bike)
    # I made the same mistake as last time. trying to have bike.working = true
    # the state of bike can only change IN BIKE !!!
    # the solution is simply to call he fix! method from bike there.
    bike.fix!
  end
end
