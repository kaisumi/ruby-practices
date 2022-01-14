# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

PREVIOUS_FRAME = -2
ONE_BEFORE_LAST_FRAME = -3
FINAL_FRAME = 10

class Game
  def initialize(text_shots = '')
    @text_shots = []
    @frames = []
    text_to_score(text_shots) unless text_shots.empty?
  end

  # 別の使用方法として、リアルタイムにショットを追加して現在のスコアを確認できるようにしています。
  def <<(shot_score)
    shot_to_frames(shot_score)
  end

  # 別の使用方法として、リアルタイムにショットを追加した際に現在のフレームを確認できるようにしています。
  def frame_count
    @frames.count
  end

  def score
    @frames.sum(&:score)
  end

  private

  def text_to_score(text_shots)
    @text_shots = text_shots.split(',')
    @text_shots.each do |text_shot|
      shot_to_frames(text_shot)
    end
  end

  def shot_to_frames(text_shot)
    shot = Shot.new(text_shot)

    shot_to_frame(shot)
    add_extra_scores(shot)
  end

  def shot_to_frame(shot)
    if @frames.count < FINAL_FRAME
      if @frames.empty? || @frames.last.frame_ended?     # 1投目
        @frames << Frame.new(shot)
      else                                               # 2投目
        @frames.last << shot
      end
    else
      @frames.last << shot
    end
  end

  def add_extra_scores(shot)
    @frames[PREVIOUS_FRAME]&.add_extra_score(shot)
    @frames[ONE_BEFORE_LAST_FRAME]&.add_extra_score(shot)
  end
end
