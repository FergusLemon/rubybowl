class Frame

  MAX_PINS = 10

  attr_reader :history

  def initialize
    @history = []
  end

  def record_frame_score(number)
    history << number
  end
end
