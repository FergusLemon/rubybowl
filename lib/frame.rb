class Frame

  MAX_PINS = 10

  attr_reader :history

  def initialize
    @history = []
  end

  def record_frame_score(number)
    if history.length == 2
      history.clear
      history << number
    else
      history << number
    end
  end
end
