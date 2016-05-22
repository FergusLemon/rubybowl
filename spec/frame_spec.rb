require 'frame'
describe Frame do

  subject(:frame) { described_class.new }

  describe 'Frame::MAX_PINS' do
    it 'has a maximum of 10 pins' do
      expect(Frame::MAX_PINS).to equal(10)
    end
  end
end
