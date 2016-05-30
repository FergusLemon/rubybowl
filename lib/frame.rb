class Frame

  MAX_PINS = 10

  attr_reader :history, :remaining_pins

  def initialize
    @history = []
    @remaining_pins = MAX_PINS
  end

  def record_frame_score(number)
    if history.length == 1
      history << number
      history.clear
      set_pins
    elsif history.length == 0 && number == MAX_PINS
      history << number
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
end
