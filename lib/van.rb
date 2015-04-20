class Van
  attr_reader :capacity, :bikes
  def initialize
    @capacity = 15
    @bikes = []
  end

  def collect(bike, from)
    @bikes << bike
    from.bikes.delete(bike)
  end

  def release(bike, to)
    @bikes.delete(bike)
    to.bikes << bike
  end
end
