require 'van'

describe Van do
  let(:van) { Van.new }
  let(:working_bike) { double :bike, working: true }
  let(:broken_bike) { double :bike, working: false }
  let(:ds) { double :docking_station, bikes: [working_bike, broken_bike] }
  # nb: no need to test garage. As long as the collection of garage is called bikes, it should work.
  it 'has a capacity' do
    expect(van.capacity).to eq(15)
  end

  it 'can only collect a broken bike from a docking station' do
    van.collect_from_ds(broken_bike, ds)
    van.collect_from_ds(working_bike, ds)
    expect(van.bikes).to eq [broken_bike]
  end

  it 'can only collect a working bike from a garage' do
    van.collect_from_garage(broken_bike, ds)
    van.collect_from_garage(working_bike, ds)
    expect(van.bikes).to eq [working_bike]
  end

  it 'cannot collect more bikes than its capacity' do
    15.times { van.collect_from_ds(broken_bike, ds) }
    expect { van.collect_from_ds(broken_bike, ds) }.to raise_error 'This van is full'
  end

  it 'can release a working bike to a docking station' do
    van.collect_from_garage(working_bike, ds)
    van.release(working_bike, ds)
    expect(van.bikes).to eq []
  end

  it 'cannot release a bike if there are no bikes left' do
    expect { van.release(broken_bike, ds) }.to raise_error 'There is no bike to release'
  end

  it 'removes a bike from a docking station while collecting' do
    van.collect_from_ds(broken_bike, ds)
    allow(ds).to receive(:collect_from_ds)
    expect(ds.bikes).to eq [working_bike]
  end

  it 'adds a bike to a docking station while releasing' do
    third_bike_for_test = double :bike, working: false
    van.collect_from_ds(third_bike_for_test, ds)
    van.release(third_bike_for_test, ds)
    allow(ds).to receive(:release)
    expect(ds.bikes).to eq [working_bike, broken_bike, third_bike_for_test]
  end
end
