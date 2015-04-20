class Van
  attr_reader :capacity, :bikes
  def initialize(cap = 15)
    @capacity = cap
    @bikes = []
  end

  def collect_from_ds(bike, station_name)
    if @bikes.length == @capacity
      fail 'This van is full'
    else
      @bikes << bike if bike.working == false
      station_name.bikes.delete(bike)
    end
  end

  def collect_from_garage(bike, garage_name)
    if @bikes.length == @capacity
      fail 'This van is full'
    else
      @bikes << bike if bike.working == true
      garage_name.bikes.delete(bike)
    end
  end

  def release(bike, to)
    if @bikes == []
      fail 'There is no bike to release'
    else
      @bikes.delete(bike)
      to.bikes << bike
    end
  end
end

# actually I need to separate release and collect from garage & ds
# collect from ds only if working == false
# collect from garage only if working == true