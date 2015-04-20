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

  it 'can collect a broken bike from a docking station' do
    van.collect(broken_bike, ds)
    expect(van.bikes).to eq [broken_bike]
  end

  it 'can release a working bike to a docking station' do
    van.collect(working_bike, ds)
    van.release(working_bike, ds)
    expect(van.bikes).to eq []
  end

  it 'removes a bike from a docking station while collecting' do
    van.collect(broken_bike, ds)
    allow(ds).to receive(:collect)
    expect(ds.bikes).to eq [working_bike]
  end

  it 'adds a bike to a docking station while releasing' do
    van.release(working_bike, ds)
    allow(ds).to receive(:release)
    expect(ds.bikes).to eq [working_bike, broken_bike, working_bike]
  end
end
