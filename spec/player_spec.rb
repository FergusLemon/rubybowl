require 'player'
describe Player do

  subject(:player) { described_class.new }
  let(:frame) { double :frame }

  describe "#bowl" do
    it 'returns a number between 0 and 10' do
      expect(player.bowl).to be_between(0, Frame::MAX_PINS).inclusive
    end

    context 'second bowl of a frame'
    it 'returns a number less than or equal to the remaining pins' do
      allow(frame).to receive(:remaining_pins).and_return(5)
      expect(player.bowl).to be_between(0, frame.remaining_pins).inclusive
    end
  end
end
