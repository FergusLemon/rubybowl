class Frame

  MAX_PINS = 10

  attr_reader :history, :remaining_pins, :scorecard

  def initialize (scorecard)
    @history = []
    @remaining_pins = MAX_PINS
    @scorecard = scorecard
  end

  def record_frame_score(number)
    if history.length == 1
      history << number
      push_to_scorecard(history, scorecard)
      history.clear
      set_pins
    elsif history.length == 0 && number == MAX_PINS
      history.insert(0, number, 0)
      push_to_scorecard(history, scorecard)
      history.clear
    else
      history << number
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
end
