# frozen_string_literal: true

require_relative 'shot'

FULL_SCORE = 10

class Frame
  attr_accessor :strike, :spare, :shots

  def initialize(shots)
    @shots = []
    @shots = shots
    @strike = false
    @spare = false
  end

  def score
    score = 0
    @shots.each do |shot|
      score += shot.score
    end
    score
  end

  def set_status
    if @shots.first.strike?
      @strike = true
    elsif score == FULL_SCORE
      @spare = true
    end
    self
  end

  def strike_or_spare?
    @strike || @spare
  end

  def strike?
    @strike
  end
end
