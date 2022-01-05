# frozen_string_literal: true

STRIKE_EXTRA_SHOT = 2
FULL_SCORE = 10

class Shot
  attr_reader :score, :strike, :remaining_shots
  attr_accessor :end_of_frame

  def initialize
    @strike = false
    @end_of_frame = false
    @remaining_shots = 0
    @score = 0
  end

  def process_strike(text_shot)
    if text_shot == 'X'
      @strike = true
      @end_of_frame = true
      @remaining_shots = STRIKE_EXTRA_SHOT
      @score = FULL_SCORE
    else
      @score = text_shot.to_i
    end
  end
end
