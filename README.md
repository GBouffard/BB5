A complete review of the Boris Bikes Tutorial from week 1 at Makers Academy. TDD using rspec.
It includes:
- unit tests
- integration tests
- A grand finale test that I made up to make sure it was all working.

Bike
  is working when created
  can break
  can be fixed if broken
  cannot be fixed if working

DockingStation
  has a capacity when created
  can dock a bike
  can release a bike
  cannot dock more bikes than its capacity
  cannot release a bike if there are no bikes left

Garage
  has a capacity
  can dock a bike
  cannot dock more bikes than its capacity
  can release a bike
  cannot release a bike if there are no bikes left
  removes a bike from the van when docking a bike to self
  adds a bike to the van station when releasing from self
  can fix a bike once it's docked

Van
  has a capacity
  can only collect a broken bike from a docking station
  can only collect a working bike from a garage
  cannot collect more bikes than its capacity
  can release a bike to a docking station (or a garage)
  cannot release a bike if there are no bikes left
  removes a bike from a docking station (or a garage) while collecting
  adds a bike to a docking station (or a garage) while releasing

Guillaume's own Feature test; a station has 20 bikes
  they get taken. 4 come back broken. Van collects, garage fixes and van brings back to docking station. They should all work now.

Finished in 0.01633 seconds (files took 0.4822 seconds to load)
26 examples, 0 failures
