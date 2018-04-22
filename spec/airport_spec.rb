require 'airport'

describe Airport do
  context "does the plane land at the airport?" do
    it { is_expected.to respond_to(:land).with(1).argument }
    let(:plane) { instance_double Plane }

  describe '#land' do
    it 'is expected to land planes' do
      subject.land(plane)
      expect(subject.planes).to eq [plane]
    end

    it 'stores the planes when they land' do
      is_expected.to respond_to(:planes)
      expect(subject.planes).to eq []
    end
  end

  describe '#planes' do
    it { is_expected.to respond_to(:planes) }

    it 'expected to initialize with no planes' do
          expect(subject.planes).to eq []
    end
  end

  describe '#takeoff' do
    it { is_expected.to respond_to(:takeoff).with(1).argument }

    it 'is expected for planes to take off' do
      subject.land(plane)
      expect(subject.takeoff(plane)).to eq plane
    end

    it 'is expected to take away a plane after takeoff' do
      subject.land(plane)
      expect(subject.takeoff(plane)).to eq plane
    end
  end
end
end
