require 'bike'
require 'spec_helper'

describe Bike do
  bike = Bike.new
  it 'is working when created' do
    expect(bike.working).to be true
  end

  it 'can break' do
    bike.break!
    expect(bike.working).to be false
  end

  it 'can be fixed if broken' do
    bike.break!
    bike.fix!
    expect(bike.working).to be true
  end

  it 'cannot be fixed if working' do
    expect { bike.fix! }.to raise_error 'bike already working'
  end
end
