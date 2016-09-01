class Frame

  MAX_PINS = 10

  attr_reader :frame_history, :remaining_pins, :scorecard

  def initialize (scorecard)
    @frame_history = []
    @remaining_pins = MAX_PINS
    @scorecard = scorecard
  end

  def record_frame_score(number)
    if frame_history.length == 1
      frame_history << number
      push_to_scorecard(frame_history, scorecard)
      reset_frame
    elsif frame_history.length == 0 && number == MAX_PINS
      frame_history.insert(0, number, 0)
      push_to_scorecard(frame_history, scorecard)
      reset_frame
    else
      frame_history << number
      update_pins(number)
    end
  end


  private

  def set_pins
    @remaining_pins = MAX_PINS
  end

  def update_pins(number)
    @remaining_pins -= number
  end

  def push_to_scorecard(frame_score, scorecard)
    scorecard.record_frame(frame_score)
  end

  def reset_frame
    @frame_history = []
    set_pins
  end
end
