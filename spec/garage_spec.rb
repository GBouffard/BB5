require 'garage'

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

  it 'can release a bike' do
    garage.dock(broken_bike, van)
    garage.release(broken_bike, van)
    expect(garage.bikes).to eq []
  end

  it 'removes a bike from the van when docking a bike to self' do
    garage.dock(broken_bike, van)
    allow(van).to receive(:dock)
    expect(van.bikes).to eq [working_bike]
  end

  it 'adds a bike to the docking station when releasing from self' do
    garage.release(working_bike, van)
    allow(van).to receive(:release)
    expect(van.bikes).to eq [working_bike, broken_bike, working_bike]
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
