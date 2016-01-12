require 'station'

describe Station do
  subject(:station) { described_class.new(:Bank) }

  it 'states the name' do
    expect(station.name).to eq(:Bank)
  end

  it 'states the zone' do
    expect(station.zone).to eq 1
  end
end