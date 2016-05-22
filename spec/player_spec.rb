require 'player'
describe Player do

  subject(:player) {described_class.new}

  describe "#bowl" do
    it 'returns a number between 0 and 10' do
      expect(player.bowl).to be_between(0, 10).inclusive
    end
  end
end
