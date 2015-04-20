class Van
  attr_reader :capacity, :bikes
  def initialize(cap = 15)
    @capacity = cap
    @bikes = []
  end

  def collect(bike, from)
    if @bikes.length == @capacity
      fail 'This van is full'
    else
      @bikes << bike
      from.bikes.delete(bike)
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
