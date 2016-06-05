class Game

  def is_spare? (frame_score)
    frame_score.flatten.reduce(0, :+) == 10 && is_strike?(frame_score) == false
  end

  def is_strike? (frame_score)
    frame_score[0] == 10
  end
end
