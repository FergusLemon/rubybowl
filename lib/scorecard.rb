class Scorecard

  attr_reader :history

  def initialize
    @history = []
    @bonus_history = []
  end

  def record_frame (container)
    history << container
  end

  def calculate_score
    history.flatten.reduce(0, :+)
  end

  def is_spare? (frame_score)
    frame_score.flatten.reduce(0, :+) == 10 && is_strike?(frame_score) == false
  end

  def is_strike? (frame_score)
    frame_score[0] == 10
  end

  def calculate_bonus

  end
end
