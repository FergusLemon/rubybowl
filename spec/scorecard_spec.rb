require 'scorecard'
describe Scorecard do
  subject(:scorecard) { described_class.new }
  let(:normal_frame) { [2, 7] }
  let(:spare) { [5, 5] }
  let(:strike) { [10, 0] }
  let(:gutter_ball) { [0, 0] }
  let(:fresh_scorecard) { [[0, 0]] }

  describe '#recordFrame' do
    context 'during the first nine frames' do
      it 'records a frame' do
        scorecard.recordFrame(normal_frame)
        expect(scorecard.history).to eq([gutter_ball, normal_frame])
      end
    end

    context 'during the tenth frame' do
      it 'records scores normally where there is no strike or spare' do
        10.times do scorecard.recordFrame(normal_frame) end
        expect(scorecard.history.last).to eq(gutter_ball)
      end
    end
  end

  describe '#calculateScore' do
    context 'no bonus score' do
      it 'calculates the current score' do
        3.times do scorecard.recordFrame(normal_frame) end
        expect(scorecard.calculateScore(scorecard.history)).to eq(27)
      end
    end
    context 'includes a spare' do
      it 'adds on the score of the first ball in the next frame' do
        scorecard.recordFrame(spare)
        scorecard.recordFrame(normal_frame)
        expect(scorecard.calculateScore(scorecard.history)).to eq(21)
      end
    end
    context 'includes a strike' do
      it 'adds on the score of the first and second ball in the next frame' do
        scorecard.recordFrame(strike)
        scorecard.recordFrame(normal_frame)
        expect(scorecard.calculateScore(scorecard.history)).to eq(28)
      end
    end
    context 'perfect game' do
      it 'correctly calculates the score for a perfect game' do
        12.times do scorecard.recordFrame(strike) end
        expect(scorecard.calculateScore(scorecard.player_history[0])).to eq(300)
      end

      it 'correctly calculates the score for 10 consecutive strikes' do
        10.times do scorecard.recordFrame(strike) end
        expect(scorecard.calculateScore(scorecard.history)).to eq(270)
      end
    end
  end

  describe '#isSpare?' do
    it 'knows what a spare is' do
      expect(scorecard.isSpare?(spare)).to be true
    end

    it 'knows a strike is not a spare' do
      expect(scorecard.isSpare?(strike)).to be false
    end
  end

  describe '#gameOver?' do
    context 'no strike or spare in the tenth frame' do
      it 'ends the game after ten frames' do
        11.times do scorecard.recordFrame(normal_frame) end
        expect(scorecard.history).to eq([gutter_ball, normal_frame])
        #expect(scorecard.recordFrame(normal_frame)).to output('Thank you for playing Ruby Bowl your score was 90.').to_stdout_from_any_process
      end
    end

    context 'spare in the tenth frame' do
      it 'ends the game after one bonus roll' do
        11.times do scorecard.recordFrame(spare) end
        expect(scorecard.player_history[0].last).to eq([5, 0])
      end
    end

    context 'strike in the tenth frame, followed by no strike' do
      it 'end the game after two bonus rolls' do
        10.times do scorecard.recordFrame(strike) end
        2.times do scorecard.recordFrame(normal_frame) end
        expect(scorecard.history).to eq([gutter_ball, normal_frame])
      end
    end

    context 'strike in the tenth frame, followed by two strikes' do
      it 'ends the game after the second strike' do
        13.times do scorecard.recordFrame(strike) end
        expect(scorecard.history).to eq([gutter_ball, strike])
      end
    end
  end

  describe '#calculateBonus' do
    context 'for a spare' do
      it 'adds the following score from the next bowl' do
        scorecard.recordFrame(spare)
        scorecard.recordFrame(normal_frame)
        expect(scorecard.calculateBonus(scorecard.history)).to eq(2)
      end
    end
  end
end
