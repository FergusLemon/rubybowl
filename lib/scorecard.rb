class Scorecard

  attr_reader :history, :game_over

  STRIKE = [10, 0]
  MAX_SCORE = 10

  def initialize
    @history = [[0, 0]]
    @game_over = false
  end

  def record_frame (frame_score)
    if frames129
      history << frame_score
    elsif finalFrameNoSpecial(frame_score) || finalFrameDoubleStrike(frame_score)
      history << frame_score
    elsif finalFrameSpare(frame_score)
      history << [frame_score[0], 0]
    else finalFrameStrike(frame_score)
      history << frame_score
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

  def reset_scorecard
    @history = [[0, 0]]
    @game_over = false
  end

  def display_score
    puts "Thank you for playing Ruby Bowl your score was #{self.calculate_score}."
    puts "Would you like to play again?"
    res = gets.chomp
    res == 'yes' ? reset_scorecard : exit
  end

  def frames129
    history.length < 10
  end

  def finalFrameNoSpecial (frame_score)
    history.length == 10 && frame_score != STRIKE && !is_spare?(frame_score)
  end

  def finalFrameSpare (frame_score)
    history.length == 11 && is_spare?(history.last)
  end

  def finalFrameStrike (frame_score)
    history.length == 11 && history.last == STRIKE
  end

  def finalFrameDoubleStrike (frame_score)
    history.length == 12 && history.last == STRIKE
  end
end
