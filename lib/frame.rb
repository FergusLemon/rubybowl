class Frame

  MAX_PINS = 10

  attr_reader :history, :remaining_pins

  def initialize
    @history = []
    @remaining_pins = MAX_PINS
  end

  def record_frame_score(number)
    if history.length == 2
      history.clear
      remaining_pins == MAX_PINS
      history << number
      @remaining_pins -= number
    elsif history.length == 0 && number == MAX_PINS
      history << number
      history.clear
    else
      history << number
      @remaining_pins -= number
    end
  end
end
