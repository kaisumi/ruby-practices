# frozen_string_literal: true

require_relative 'shot'

SPARE_EXTRA_SHOT = 1
STRIKE_EXTRA_SHOT = 2
NORMAL_FRAME_SHOTS = 2
STRIKE_SHOT = 1
NO_REMAINING_SHOT = 0

class Frame
  def initialize(shot = nil)
    @shots = []
    @shots << shot unless shot.nil?
  end

  def strike?
    @shots.first.score == FULL_SCORE
  end

  def spare?
    @shots[0..1].sum(&:score) == FULL_SCORE && !strike?
  end

  def <<(shot)
    @shots << shot
    return unless spare?
  end

  def score
    @shots.sum(&:score)
  end

  def frame_ended?
    @shots.count >= NORMAL_FRAME_SHOTS || strike?
  end

  def remaining_shots
    if strike?
      STRIKE_SHOT + STRIKE_EXTRA_SHOT - @shots.count
    elsif spare?
      NORMAL_FRAME_SHOTS + SPARE_EXTRA_SHOT - @shots.count
    else
      NO_REMAINING_SHOT
    end
  end
end
