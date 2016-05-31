require_relative 'frame'
class Player

  attr_reader :frame, :scorecard

  def initialize (frame_klass = Frame.new, scorecard_klass = Scorecard.new)
    @frame = frame_klass
    @scorecard = scorecard_klass
  end

  def bowl
    number = rand(frame.remaining_pins + 1)
    frame.record_frame_score(number)
    number
  end

  def get_score
    @scorecard.calculate_current_score
  end
end
