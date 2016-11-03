class Scorecard

  attr_reader :history

  STRIKE = [10, 0]
  MAX_SCORE = 10

  def initialize
    @history = [[0, 0]]
  end

  def record_frame (frame_score)
    history << frame_score
  end

  def calculate_score
    score = history.flatten.reduce(&:+)
    bonus = self.calculate_bonus(history)
    score + bonus
  end

  def is_spare? (frame_score)
    frame_score.flatten.reduce(&:+) == MAX_SCORE && frame_score != STRIKE
  end

  def calculate_bonus (history)
    b = history.each_with_index.map { |frame, i| if frame == STRIKE && history[i + 1] != STRIKE
        history[i + 1]
      elsif frame == STRIKE && history[i + 1] == STRIKE
        var = history[i + 1, 2]
        var.flatten.take(3)
      elsif frame.reduce(&:+) == MAX_SCORE
        history[i + 1][0]
      else
        0
      end }
    b.flatten.compact.reduce(&:+)
  end
end
