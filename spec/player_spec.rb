require 'player'
describe Player do

  subject(:player) {described_class.new}

  describe "#bowl" do
    it { is_expected.to respond_to :bowl }
  end
end
