# frozen_string_literal: true

require_relative 'shot'

# FULL_SCORE = 10
SPARE_EXTRA_SHOT = 1

class Frame
  attr_accessor :spare, :score, :remaining_shots
  attr_reader :strike

  def initialize(shot)
    @spare = false
    @shots = []
    @shots << shot
    @score = shot.score
    @strike = shot.strike
    @remaining_shots = shot.remaining_shots
  end

  def <<(shot)
    @shots << shot
    @score += shot.score
    return unless @score == FULL_SCORE

    @spare = true
    @remaining_shots += SPARE_EXTRA_SHOT
  end
end
