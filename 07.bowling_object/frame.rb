# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(shots)
    @shots = shots
  end

  def <<(shot)
    @shots << shot
  end

  def strike_or_spare?
    strike? || spare?
  end

  def strike?
    @shots.first.score == FULL_SCORE
  end

  def spare?
    !strike? && @shots[0..1].sum(&:score) == FULL_SCORE
  end

  def score
    @shots.sum(&:score)
  end
end
