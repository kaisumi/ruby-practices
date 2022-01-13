# frozen_string_literal: true

require_relative 'shot'

SPARE_EXTRA_SHOT = 1
STRIKE_EXTRA_SHOT = 2
NORMAL_FRAME_SHOTS = 2
STRIKE_SHOT = 1
NO_REMAINING_SHOT = 0

class Frame
  # 引数なし：インスタンス作成のみ、引数あり：インスタンス作成＋データ挿入
  def initialize(shot = nil)
    @shots = []
    self << shot unless shot.nil?
  end

  def <<(shot)
    @shots << shot
  end

  def strike?
    @shots.first.score == FULL_SCORE
  end

  def spare?
    @shots[0..1].sum(&:score) == FULL_SCORE && !strike?
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

  def add_extra_score(shot)
    self << shot unless remaining_shots.zero?
  end
end
