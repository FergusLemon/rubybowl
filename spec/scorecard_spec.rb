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

  describe '#is_spare?' do
    it 'knows what a spare is' do
      expect(scorecard.is_spare?([5, 5])).to be true
    end

    it 'knows a strike is not a spare' do
      expect(scorecard.is_spare?([10, 0])).to be false
    end
  end

  describe '#is_strike?' do
    it 'knows what a strike is' do
      expect(scorecard.is_strike?([10, 0])).to be true
    end
  end

  describe '#calculate_bonus' do
    context 'for a spare' do
      it 'adds the following score from the next bowl' do
        scorecard.record_frame([5, 5])
        scorecard.record_frame([2, 7])
        expect(scorecard.calculate_bonus).to eq(2)
      end
    end
  end
end
