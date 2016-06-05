require 'game'
describe Game do

  let(:game) { described_class.new }

  describe '#is_spare?' do
    it 'knows what a spare is' do
      expect(game.is_spare?([5, 5])).to be true
    end

    it 'knows a strike is not a spare' do
      expect(game.is_spare?([10, 0])).to be false
    end
  end

  describe '#is_strike?' do
    it 'knows what a strike is' do
      expect(game.is_strike?([10, 0])).to be true
    end
  end
end
