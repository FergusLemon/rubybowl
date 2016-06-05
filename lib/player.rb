require './lib/frame'
class Player

  attr_reader :frame

  def initialize (frame)
    @frame = frame
  end

  def bowl
    number = rand(frame.remaining_pins + 1)
    frame.record_frame_score(number)
    number
  end

  def get_score (scorecard)
    scorecard.calculate_score
  end
end
