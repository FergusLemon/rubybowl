require 'frame'
describe Frame do

  subject(:frame) { described_class.new(scorecard) }
  let(:scorecard) { double :scorecard }
  let(:strike) { 10 }

  describe 'Frame::MAX_PINS' do
    it 'has a maximum of 10 pins' do
      expect(Frame::MAX_PINS).to equal(strike)
    end
  end

  describe '#record_frame_score' do

    before(:each) do
      allow(scorecard).to receive(:record_frame)
    end
    context 'frames 1 to 9' do
      it 'records a score' do
        frame.record_frame_score(2)
        expect(frame.history).to match_array([2])
      end

      it 'records a maximum of 2 scores' do
        3.times do frame.record_frame_score(4) end
        expect(frame.history).to match_array([4])
      end

      it 'records a strike on the first bowl' do
        frame.record_frame_score(strike)
        expect(frame.history).to match_array([])
      end
    end

    context 'frame is finished' do
      before(:each) do
        2.times do frame.record_frame_score(2) end
        allow(scorecard).to receive(:history).and_return([[2, 2]])
      end

      it 'resets pins back to MAX_PINS' do
        expect(frame.remaining_pins).to eq(Frame::MAX_PINS)
      end

      it 'stores the score in a scorecard' do
        expect(frame.scorecard.history).to eq([[2, 2]])
      end
    end
  end

end
