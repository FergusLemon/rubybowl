require 'scorecard'
describe Scorecard do
  subject(:scorecard) { described_class.new }

  describe '#record_frame' do
    it 'records a frame' do
      scorecard.record_frame([2, 7])
      expect(scorecard.history).to eq([[2, 7]])
    end
  end

  describe '#calculate_score' do
    it 'calculates the current score' do
      3.times do scorecard.record_frame([2, 7]) end
      expect(scorecard.calculate_score).to eq(27)
    end
  end
end
