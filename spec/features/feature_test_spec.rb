require 'capybara/rspec'
require 'bike'
require 'docking_station'
require 'garage'
require 'van'
require 'spec_helper'

feature 'Guillaume\'s own Feature test; a station has 20 bikes' do
  scenario 'they get taken. 4 come back broken. Van collects, garage fixes and van brings back' do
    ds = DockingStation.new
    20.times { ds.dock(Bike.new) }
    bikeslist = ds.bikes
    # I just realised that we are missing a user class that allow us to track
    # each individual bike when we release them! so if I release as...
    # ds.bikes.each { |bike| ds.release(bike) }
    # we cannot track them! On the other hand, in London, bikes go from left to right
    # and it may not be the exact same bikes coming back to that station. We'll just break 4.
    bikeslist[4].break!
    bikeslist[7].break!
    bikeslist[11].break!
    bikeslist[19].break!
    expect(ds.bikes.all?(&:working)).to be false
    van = Van.new
    bikeslist.each { |bike| van.collect_from_ds(bike, ds) }
    expect(van.bikes.length).to eq(4)
    garage = Garage.new
    # because .each with a delete inside the code changes the array
    # as in [0] ok and [1] ok, but then the array has nothing at [2] & [3] because
    # now this array has a size 2, I had to find another way to iterrate through my bikes.
    # we load the 4 broken bikes in the van.
    (van.bikes.length).times { garage.dock(van.bikes[0], van) }
    expect(van.bikes.length).to eq(0)
    expect(garage.bikes.length).to eq(4)
    # the garage fixes them all
    garage.bikes.each { |bike| garage.fix_a_bike(bike) }
    # we load them back in the van
    (garage.bikes.length).times { garage.release(garage.bikes[0], van) }
    expect(garage.bikes.length).to eq(0)
    expect(van.bikes.length).to eq(4)
    # we put them all in the station
    (van.bikes.length).times { van.release(van.bikes[0], ds) }
    expect(van.bikes.length).to eq(0)
    expect(ds.bikes.length).to eq(20)
    # and they should all be working.
    expect(ds.bikes.all?(&:working)).to be true
  end
end
