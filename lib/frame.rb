class Frame

  MAX_PINS = 10

  attr_reader :frame_history, :remaining_pins, :scorecard

  def initialize (scorecard)
    @frame_history = []
    @remaining_pins = MAX_PINS
    @scorecard = scorecard
  end

  def recordScore(number)
    if frame_history.length == 1
      frame_history << number
      pushToScorecard(frame_history, scorecard)
      resetFrame
    elsif frame_history.length == 0 && number == MAX_PINS
      frame_history.insert(0, number, 0)
      pushToScorecard(frame_history, scorecard)
      resetFrame
    else
      frame_history << number
      updatePins(number)
    end
  end

  private

  def setPins
    @remaining_pins = MAX_PINS
  end

  def updatePins(number)
    @remaining_pins -= number
  end

  def pushToScorecard(frame_score, scorecard)
    scorecard.recordFrame(frame_score)
  end

  def resetFrame
    @frame_history = []
    setPins
  end

end
