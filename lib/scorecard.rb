class Scorecard

  attr_reader :history, :game_over, :player_history

  STRIKE = [10, 0]
  MAX_SCORE = 10

  def initialize
    @history = [[0, 0]]
    @game_over = false
    @player_history = []
  end

  def recordFrame (frame_score)
    if frames129 || finalFrameStrike(frame_score)
      recordScore(frame_score)
    elsif finalFrameNoSpecial(frame_score) || finalFrameDoubleStrike(frame_score)
      recordScore(frame_score)
      gameOver
    elsif finalFrameSpare(frame_score)
      history << [frame_score[0], 0]
      gameOver
    else
      history << frame_score
    end
  end

  def calculateScore (history)
    score = history.flatten.reduce(&:+)
    bonus = self.calculateBonus(history)
    score + bonus
  end

  def isSpare? (frame_score)
    frame_score.flatten.reduce(&:+) == MAX_SCORE && frame_score != STRIKE
  end

  def calculateBonus (history)
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

  def resetScorecard
    @history = [[0, 0]]
  end

  def gameOver
    @game_over = true
    gameOverMessage
  end

  def gameOverMessage
    puts "Thank you for playing Ruby Bowl your score was #{self.calculateScore(history)}."
    puts "Would you like to play again?"
    res = gets.chomp
    if res == 'yes'
      player_history.push(history)
      resetScorecard
      puts "Please go right ahead and bowl"
    else
      puts "Thank you for playing"
      exit
    end
  end

  private

  def frames129
    history.length < 10
  end

  def finalFrameNoSpecial (frame_score)
    history.length == 10 && frame_score != STRIKE && !isSpare?(frame_score)
  end

  def finalFrameSpare (frame_score)
    history.length == 11 && isSpare?(history.last)
  end

  def finalFrameStrike (frame_score)
    history.length == 11 && history.last == STRIKE
  end

  def finalFrameDoubleStrike (frame_score)
    history.length == 12 && history.last == STRIKE
  end

  def recordScore (frame_score)
    history.push(frame_score)
  end
end
