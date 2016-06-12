class Scorecard

  attr_reader :history

  def initialize
    @history = [[0, 0]]
    @bonus_history = []
  end

  def record_frame (container)
    if self.is_strike?(history.last)
      @bonus_history << container && history << container
    elsif
      self.is_spare?(history.last)
      @bonus_history << container[0] && history << container
    else
      history << container
    end
  end

  def calculate_score
    history.flatten.reduce(0, :+)
  end

  def is_spare? (frame_score)
    frame_score.flatten.reduce(0, :+) == 10 && is_strike?(frame_score) == false
  end

  def is_strike? (frame_score)
    frame_score == [10, 0]
  end

  def calculate_bonus
    @bonus_history.flatten.reduce(0, :+)
  end
end
