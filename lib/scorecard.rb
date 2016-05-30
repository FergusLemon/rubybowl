class Scorecard

  attr_reader :history

  def initialize
    @history = []
  end

  def record_frame (container)
    history << container
  end

  def calculate_current_score
    history.flatten.reduce(0, :+)
  end
end
