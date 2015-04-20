class DockingStation
  attr_reader :capacity, :bikes
  def initialize
    @capacity = 30
    @bikes = []
  end

  def dock(bike)
    if @bikes.length == @capacity
      fail 'This station is full'
    else
      @bikes << bike
    end
  end

  def release(bike)
    # why can I not write in trnary as
    # (@bikes == []) ? fail 'There is no bike to release' : @bikes.delete(bike)
    if @bikes == []
      fail 'There is no bike to release'
    else
      @bikes.delete(bike)
    end
  end
end
