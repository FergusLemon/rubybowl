class Scorecard

  attr_reader :history

  def initialize
    @history = []
  end

  def record_frame (container)
    history << container
  end
end
