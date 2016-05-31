require_relative 'frame'
class Player

  attr_reader :frame

  def initialize (frame_klass = Frame.new)
    @frame = frame_klass
  end

  def bowl
    number = rand(frame.remaining_pins + 1)
    frame.record_frame_score(number)
    number
  end

  def get_score (scorecards)
    scorecards.each { |scorecard| scorecard.calculate_score }
  end
end
