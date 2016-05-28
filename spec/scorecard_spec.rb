require 'scorecard'
describe Scorecard do
  subject(:scorecard) { described_class.new }

  describe '#record_frame' do
    it 'records a frame' do
      scorecard.record_frame([2, 7])
      expect(scorecard.history).to equal([2, 7])
    end
  end
end
