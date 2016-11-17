class Scorecard

  attr_reader :history

  STRIKE = [10, 0]
  MAX_SCORE = 10

  def initialize
    @history = [[0, 0]]
  end

  def record_frame (frame_score)
    if history.length < 11
      history << frame_score
    elsif history.length == 11 && history.last != STRIKE && self.is_spare?(history.last) == false
      self.end_game
    elsif history.length == 11 && self.is_spare?(history.last)
      history << [frame_score[0], 0]
      self.end_game
    else history.length < 13 && history.last == STRIKE
      history << frame_score
      self.end_game
    end
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
    bonus = history.each_with_index.map { |frame, i|
      if frame == STRIKE && history[i + 1] != STRIKE
        history[i + 1]
      elsif frame == STRIKE && history[i + 1] == STRIKE
        var = history[i + 1, 2]
        var.flatten.take(3)
      elsif frame.reduce(&:+) == MAX_SCORE
        history[i + 1][0]
      else
        0
      end}
    bonus[0, 10].flatten.compact.reduce(&:+)
  end

  def end_game
    puts "Thank you for playing Ruby Bowl your score was #{self.calculate_score}."
  end
end
