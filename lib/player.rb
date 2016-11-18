require './lib/frame'
class Player

  attr_reader :frame

  def initialize (frame)
    @frame = frame
  end

  def bowl
    number = rand(frame.remaining_pins + 1)
    frame.recordScore(number)
    number
  end

  def getScore (scorecard)
    scorecard.calculateScore
  end
end
