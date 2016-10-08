require 'scorecard'
describe Scorecard do
  subject(:scorecard) { described_class.new }
  let(:normal_frame) { [2, 7] }
  let(:spare) { [5, 5] }
  let(:strike) { [10, 0] }
  let(:gutter_ball) { [0, 0] }

  describe '#record_frame' do
    it 'records a frame' do
      scorecard.record_frame(normal_frame)
      expect(scorecard.history).to eq([gutter_ball, normal_frame])
    end
  end

  describe '#calculate_score' do
    context 'no bonus score' do
      it 'calculates the current score' do
        3.times do scorecard.record_frame(normal_frame) end
        expect(scorecard.calculate_score).to eq(27)
      end
    end
    context 'includes a spare' do
      it 'adds on the score of the first ball in the next frame' do
        scorecard.record_frame(spare)
        scorecard.record_frame(normal_frame)
        expect(scorecard.calculate_score).to eq(21)
      end
    end
    context 'includes a strike' do
      it 'adds on the score of the first and second ball in the next frame' do
        p scorecard
        scorecard.record_frame(strike)
        p scorecard
        scorecard.record_frame(normal_frame)
        p scorecard
        expect(scorecard.calculate_score).to eq(28)
      end
    end
    context 'perfect game' do
      it 'correctly calculates the score for a perfect game' do
        10.times do scorecard.record_frame(strike) end
        expect(scorecard.calculate_score).to eq(300)
      end
    end
  end

  describe '#is_spare?' do
    it 'knows what a spare is' do
      expect(scorecard.is_spare?(spare)).to be true
    end

    it 'knows a strike is not a spare' do
      expect(scorecard.is_spare?(strike)).to be false
    end
  end

  describe '#is_strike?' do
    it 'knows what a strike is' do
      expect(scorecard.is_strike?(strike)).to be true
    end
  end

  describe '#calculate_bonus' do
    context 'for a spare' do
      it 'adds the following score from the next bowl' do
        scorecard.record_frame(spare)
        scorecard.record_frame(normal_frame)
        expect(scorecard.calculate_bonus).to eq(2)
      end
    end
  end
end
