require 'docking_station'

describe DockingStation do
  let(:ds) { DockingStation.new }
  let(:bike) { double :bike }
  it 'has a capacity when created' do
    expect(ds.capacity).to eq(30)
  end

  it 'can dock a bike' do
    ds.dock(bike)
    expect(ds.bikes).to eq [bike]
  end

  it 'can release a bike' do
    ds.dock(bike)
    ds.release(bike)
    expect(ds.bikes).to eq []
  end

  it 'cannot dock more bikes than its capacity' do
    30.times { ds.dock(bike) }
    expect { ds.dock(bike) }.to raise_error 'This station is full'
  end

  it 'cannot release a bike if there are no bikes left' do
    expect { ds.release(bike) }.to raise_error 'There is no bike to release'
  end
end
