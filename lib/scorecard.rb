class Scorecard

  attr_reader :history, :bonus_history

  def initialize
    @history = [[0, 0]]
    @bonus_history = [0]
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
    score = history.flatten.reduce(0, :+)
    bonus = self.calculate_bonus(history)
    score + bonus
  end

  def is_spare? (frame_score)
    frame_score.flatten.reduce(0, :+) == 10 && is_strike?(frame_score) == false
  end

  def is_strike? (frame_score)
    frame_score == [10, 0]
  end

  def calculate_bonus (history)
    b = history.each_with_index.map { |frame, i| if frame == [10, 0] && history[i + 1] != [10, 0]
        history[i + 1]
      elsif frame == [10, 0] && history[i + 1] == [10, 0]
        var = history[i + 1, 2]
        var.flatten.take(3)
      elsif frame.reduce(&:+) == 10
        history[i + 1][0]
      else
        0
      end }
    b.flatten.reduce(&:+)
  end
end
