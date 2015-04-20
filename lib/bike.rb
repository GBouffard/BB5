class Bike
  attr_reader :working
  def initialize
    @working = true
  end

  def break!
    @working = false
  end

  def fix!
    fail 'bike already working'if @working == true
    @working = true
  end
end
