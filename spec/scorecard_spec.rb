require 'scorecard'
describe Scorecard do
  subject(:scorecard) { described_class.new }
  let(:normal_frame) { [2, 7] }
  let(:spare) { [5, 5] }
  let(:strike) { [10, 0] }
  let(:gutter_ball) { [0, 0] }
  let(:fresh_scorecard) { [[0, 0]] }

  describe '#record_frame' do
    context 'during the first nine frames' do
      it 'records a frame' do
        scorecard.record_frame(normal_frame)
        expect(scorecard.history).to eq([gutter_ball, normal_frame])
      end
    end

    context 'during the tenth frame' do
      it 'records scores normally where there is no strike or spare' do
        9.times do scorecard.record_frame(normal_frame) end
        scorecard.record_frame(normal_frame)
        expect(scorecard.history.last).to eq(normal_frame)
      end
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
        scorecard.record_frame(strike)
        scorecard.record_frame(normal_frame)
        expect(scorecard.calculate_score).to eq(28)
      end
    end
    context 'perfect game' do
      it 'correctly calculates the score for a perfect game' do
        12.times do scorecard.record_frame(strike) end
        print scorecard.history
        print scorecard.calculate_bonus(scorecard.history)
        expect(scorecard.calculate_score).to eq(300)
      end

      it 'correctly calculates the score for 10 consecutive strikes' do
        10.times do scorecard.record_frame(strike) end
        expect(scorecard.calculate_score).to eq(270)
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

  describe '#end_game' do
    context 'no strike or spare in the tenth frame' do
      it 'ends the game after ten frames' do
        10.times do scorecard.record_frame(normal_frame) end
        expect(scorecard.history).to eq(fresh_scorecard)
        #expect(scorecard.record_frame(normal_frame)).to output('Thank you for playing Ruby Bowl your score was 90.').to_stdout_from_any_process
      end
    end

    context 'spare in the tenth frame' do
      it 'ends the game after one bonus roll' do
        11.times do scorecard.record_frame(spare) end
        expect(scorecard.history.length).to eq(1)
      end
    end

    context 'strike in the tenth frame, followed by no strike' do
      it 'end the game after two bonus rolls' do
        10.times do scorecard.record_frame(strike) end
        scorecard.record_frame(normal_frame)
        expect(scorecard.history).to eq(fresh_scorecard)
      end
    end

    context 'strike in the tenth frame, followed by two strikes' do
      it 'ends the game after the second strike' do
        13.times do scorecard.record_frame(strike) end
        print scorecard.history
        expect(scorecard.history.length).to eq(2)
      end
    end
  end

  describe '#calculate_bonus' do
    context 'for a spare' do
      it 'adds the following score from the next bowl' do
        scorecard.record_frame(spare)
        scorecard.record_frame(normal_frame)
        expect(scorecard.calculate_bonus(scorecard.history)).to eq(2)
      end
    end
  end
end
