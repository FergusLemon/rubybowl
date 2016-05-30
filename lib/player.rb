require_relative 'frame'
class Player

  attr_reader :frame

  def initialize (frame_klass = Frame.new)
    @frame = frame_klass
  end

  def bowl
    rand(frame.remaining_pins + 1)
  end
end
