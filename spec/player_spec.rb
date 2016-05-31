require 'player'
describe Player do

  subject(:player) { described_class.new(frame)}
  let(:frame) { double :frame }

  describe "#bowl" do
    it 'returns a number between 0 and 10' do
      allow(frame).to receive(:remaining_pins).and_return(Frame::MAX_PINS)
      allow(frame).to receive(:record_frame_score)
      expect(player.bowl).to be_between(0, Frame::MAX_PINS).inclusive
    end

    context 'second bowl of a frame'
    it 'returns a number less than or equal to the remaining pins' do
      allow(frame).to receive(:remaining_pins).and_return(5)
      allow(frame).to receive(:record_frame_score)
      expect(player.bowl).to be_between(0, frame.remaining_pins).inclusive
    end
  end

  describe '#get_score' do
    it 'returns the player\'s current score' do
      allow(frame).to receive(:calculate_current_score).and_return(84)
      expect(player.get_score).to eq(84)
    end
  end
end
