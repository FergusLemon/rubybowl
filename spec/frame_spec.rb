require 'frame'
describe Frame do

  subject(:frame) { described_class.new(scorecard)}
  let(:scorecard) { double :scorecard }

  describe 'Frame::MAX_PINS' do
    it 'has a maximum of 10 pins' do
      expect(Frame::MAX_PINS).to equal(10)
    end
  end

  describe '#record_frame_score' do

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
        frame.record_frame_score(10)
        expect(frame.history).to match_array([])
      end
    end
  end

  describe '#push_to_scorecard' do
    before(:each) do
      2.times do frame.record_frame_score(4) end
    end
    context 'once the frame is finished' do
      it 'records the total frame score in a scorecard' do
        expect(frame.push_to_scorecard).to have_been_called
      end
    end
  end
end
