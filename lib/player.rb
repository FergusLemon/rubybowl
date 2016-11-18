require './lib/frame'
class Player

  attr_reader :frame

  def initialize (frame)
    @frame = frame
  end

  def bowl
    pins = rand(frame.remaining_pins + 1)
    frame.recordScore(pins)
    pins
  end

  def getScore (scorecard)
    scorecard.calculateScore
  end
end
