require 'garage'
require 'spec_helper'

describe Garage do
  let(:garage) { Garage.new }
  let(:broken_bike) { double :bike, working: false }
  let(:working_bike) { double :bike, working: true }
  # at first, I created van with bikes: [broken_bike, broken_bike] }
  # but @bikes.delete(bike) with brokeb
  let(:van) { double :van, bikes: [working_bike, broken_bike] }

  it 'has a capacity' do
    expect(garage.capacity).to eq(25)
  end

  it 'can dock a bike' do
    garage.dock(broken_bike, van)
    expect(garage.bikes).to eq [broken_bike]
  end

  it 'cannot dock more bikes than its capacity' do
    25.times { garage.dock(broken_bike, van) }
    expect { garage.dock(broken_bike, van) }.to raise_error 'This garage is full'
  end

  it 'can release a bike' do
    garage.dock(broken_bike, van)
    garage.release(broken_bike, van)
    expect(garage.bikes).to eq []
  end

  it 'cannot release a bike if there are no bikes left' do
    expect { garage.release(broken_bike, van) }.to raise_error 'There is no bike to release'
  end

  it 'removes a bike from the van when docking a bike to self' do
    garage.dock(broken_bike, van)
    allow(van).to receive(:dock)
    expect(van.bikes).to eq [working_bike]
  end

  it 'adds a bike to the van station when releasing from self' do
    third_bike_for_test = double :bike
    garage.dock(third_bike_for_test, van)
    garage.release(third_bike_for_test, van)
    allow(van).to receive(:release)
    expect(van.bikes).to eq [working_bike, broken_bike, third_bike_for_test]
  end

  it 'can fix a bike once it\'s docked' do
    garage.dock(broken_bike, van)
    expect(broken_bike).to receive(:fix!)
    garage.fix_a_bike(broken_bike)
    # because I made the same mistake as last time, meaning that I also wrote
    # expect(broken_bike.working).to be true
    # the test failed. The state of a bike cannot change here. We only need to check that
    # the double receives the method. It will work on tge real thing.
  end
end
