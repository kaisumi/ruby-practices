# frozen_string_literal: true

STRIKE = 'X'
STRIKE_SCORE = 10

class Shot
  attr_reader :score

  def initialize(score)
    @strike = false
    if score == STRIKE
      @strike = true
      @score = STRIKE_SCORE
    else
      @strike = false
      @score = score.to_i
    end
  end

  def strike?
    @strike
  end
end
