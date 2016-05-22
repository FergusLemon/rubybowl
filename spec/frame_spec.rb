require 'frame'
describe Frame do

  subject(:frame) { described_class.new }
  let(:player) { double :player }

  describe 'Frame::MAX_PINS' do
    it 'has a maximum of 10 pins' do
      expect(Frame::MAX_PINS).to equal(10)
    end
  end

  describe '#record_frame_score' do

  context 'frames 1 to 9' do
    it 'consist of two bowls' do
      allow(player).to receive(:bowl).and_return(3)
      2.times { player.bowl }
      expect(frame.history.length).to equal(2)
    end
  end
  end

end
