[![Build Status](https://travis-ci.org/GBouffard/Boris-bikes.svg)](https://travis-ci.org/GBouffard/Boris-bikes) 

:bike: Boris Bikes :bike:
===========
This is me redoing the Boris Bikes tutorial from Makers Academy without the tutorial; only doing it from the users stories.

Boris Bikes is a bikes rental system in London, that allow users to rent and drop off bikes all over the city.

User stories:
```
As a member of the public,
So that I can get across town,
I'd like to get a working bike from a docking station.

As a member of the public,
So that I am not confused and charged unnecessarily,
I'd like docking stations not to release bikes when there are none available.

As a member of the public,
So that I am not charged for longer than necessary,
I'd like to return a bike to a docking station.

As a member of the public,
So that I reduce the chance of getting a broken bike in future,
I'd like to report a bike as broken when I return it.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like docking stations not to release broken bikes.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like docking stations to accept returning bikes (broken or not).

As a maintainer of the system,
So that I can control the distribution of bikes,
I'd like docking stations not to accept more bikes than their capacity.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like vans to take broken bikes from docking stations and deliver them to garages to be fixed.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like vans to collect working bikes from garages and distribute them to docking stations.
```

Objectives of exercise
----
Learn about Test-driven development, mock doubles and rspec.

Technologies used
----
- Ruby
- Rspec
- Git

How to run it
----
```
git clone git@github.com:GBouffard/Boris-bikes.git
cd Boris-bikes
irb
Dir["./lib/*"].each {|file| require file }
```
You can now play around in IRB. This is an example of commands that can be used; this example is the cycle for a broken bike to be fixed:
```
bike = Bike.new
bike.break!
ds = DockingStation.new
ds.dock(bike)
ds.release(bike)
van = Van.new
van.collect_from_ds(bike, ds)
garage = Garage.new
van.release(bike, garage)
garage.fix_a_bike(bike)
garage.release(bike, van)
van.release(bike, ds)
```

How to run tests
----
```
cd Boris-bikes-tutorial
rspec
```

How I wrote the tests and code
----
The original tutorial from Makers Academy started with feature tests but I found out that I have a preference for starting with unit tests. Once all my units tests were working, I moved to integrations tests; in the end I created a grand finale feature test to make sure that it was all working: a station has 20 bikes. They get taken. 4 come back broken. The van collects, the garage fixes and the van brings back to the docking station. The tests proved that they all work. That final test actually helped me to rectify a few tiny mistakes that were passing at units level. These are all the tests:
```
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

Guillaume's own Feature test; a station has 20 bikes
  they get taken. 4 come back broken. Van collects, garage fixes and van brings back

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
```

Room for improvement:
----

- The van, garage and docking station have some similar behaviors and as a result, a module can be used to group these behaviours. It's in my to-do list.
- I could also remove my comments but still as a learner, I found them useful; I review them from time to time to make sure I will not make these mistakes again.