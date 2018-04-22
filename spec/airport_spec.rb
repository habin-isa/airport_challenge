require 'airport'

describe Airport, :airport do
  let(:current_plane) { instance_double Plane, land: false }
  let(:next_fly_plane) { instance_double Plane, land: false }
  let(:land_plane) { instance_double Plane, takeoff: true }
  let(:next_land_plane) { instance_double Plane, takeoff: true }
  let(:stormy_weather) { instance_double Weather, stormy?: true }
  let(:good_weather) { instance_double Weather, stormy?: false }
  let(:plane) { double Plane }

  describe '#land' do
    it 'is expected to land planes' do
      subject.land(current_plane, good_weather)
      expect(subject.planes).to include current_plane
    end

    it 'is expected in stormy weather for planes not to land', :stormy_land do
      expect { subject.land(current_plane, stormy_weather) }.to raise_error "Its stormy!"
    end

    it 'stores the planes when they land' do
      is_expected.to respond_to(:planes)
      expect(subject.planes).to eq []
    end
  end

  describe '#capacity' do
    it 'should default to the capacity of 20' do
      expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
    end

    it 'has a variable capacity on initialisation' do
      capacity_two = 10
      airport = Airport.new(capacity_two)
      expect(airport.capacity).to eq capacity_two
    end

    it 'doesnt let a plane land if airport is at full capacity' do
      Airport::DEFAULT_CAPACITY.times { subject.land(current_plane, good_weather) }
      expect { subject.land(current_plane, good_weather) }.to raise_error 'Airport is full!'
    end
  end

  describe '#planes' do
    it { is_expected.to respond_to(:planes) }

    it 'expected to initialize with no planes' do
      expect(subject.planes).to eq []
    end
  end

  describe '#land' do
    it 'can let planes land' do
      subject.land(current_plane, good_weather)
      expect(subject.planes).to include current_plane
    end

    it 'shouldnt land planes in stormy weather', :stormy_land do
      expect { subject.land(current_plane, stormy_weather) }.to raise_error "Its stormy!"
    end

    it 'cant land planes in a full airport' do
      Airport::DEFAULT_CAPACITY.times { subject.land(current_plane, good_weather) }
      expect { subject.land(current_plane, good_weather) }.to raise_error 'Airport is full!'
    end
  end

  describe '#takeoff' do
    class Airport
      attr_writer :planes
    end

    it 'is expected to return a taking off a plane' do
      subject.planes = [land_plane]
      expect(subject.takeoff(land_plane, good_weather)).to eq land_plane
    end

    it 'is expected for planes array to be empty after take off' do
      subject.planes = [land_plane]
      subject.takeoff(land_plane, good_weather)
      expect(subject.planes).to be_empty
    end

    it 'is expected to still contain one plane in array when another takes off' do
      subject.planes = [land_plane, next_land_plane]
      subject.takeoff(land_plane, good_weather)
      expect(subject.planes).to include next_land_plane
    end

    it 'is expected not to let planes take off in stormy weather', :storm_take_off do
      subject.planes = [land_plane]
      expect { subject.takeoff(land_plane, stormy_weather) }.to raise_error "Its stormy!"
    end

    it "raises error if the plane taking off is not in airport", :no_plane do
      expect { subject.takeoff(land_plane, good_weather) }.to raise_error 'Plane isnt docked in airport'
    end
  end
end
