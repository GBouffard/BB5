require 'capybara/rspec'
require 'bike'
require 'docking_station'
require 'garage'
require 'van'

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
    van = Van.new
    bikeslist.each { |bike| van.collect_from_ds(bike, ds) }
    expect(van.bikes.length).to eq (4)
  end
end
