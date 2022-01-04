# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

NUMBER_OF_FRAMES = 10
NOT_ENOUGH_ERROR = '【エラー】ショットの数が足りません。'
NEXT = 1
ONE_AFTER_NEXT = 2
TO_SECOND = 1
TO_THIRD = 2

class Game
  attr_reader :score, :frames

  def initialize(text_scores)
    @text_scores = text_scores.split(',')
    @shots = text_to_shots
    @frames = shots_to_frames
    @score = frames_to_score
  end

  private

  def text_to_shots
    @text_scores.map do |score|
      Shot.new(score)
    end
  end

  def shots_to_frames
    shot_idx = 0
    frames = []
    NUMBER_OF_FRAMES.times do # フレームごとにスコアを加算。ストライク：3ショット、スペア：3ショット、その他：2ショット
      raise NOT_ENOUGH_ERROR if @shots[shot_idx].nil? || @shots[shot_idx + TO_SECOND].nil?

      frame = Frame.new([@shots[shot_idx], @shots[shot_idx + TO_SECOND]]) # 1ショット目、2ショット目
      if frame.set_status.strike_or_spare?
        raise NOT_ENOUGH_ERROR if @shots[shot_idx + TO_THIRD].nil?

        frame.shots << @shots[shot_idx + TO_THIRD] # 3ショット目（ストライクまたはスペアの場合）
      end
      shot_idx += (frame.strike? ? NEXT : ONE_AFTER_NEXT) # 次のフレームの先頭に移動（ストライクの場合は次のショット、それ以外は2ショット先）
      frames << frame
    end
    frames
  end

  def frames_to_score
    @frames.map(&:score).sum
  end
end
