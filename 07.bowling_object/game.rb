# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

PREVIOUS_FRAME = -1
ONE_BEFORE_LAST_FRAME = -2
FINAL_FRAME = 10

class Game
  attr_reader :score

  def initialize
    @frame_count = 0
    @text_shots = []
    @shots = []
    @frames = []
    @score = 0
  end

  def text_to_score(text_shots)
    @text_shots = text_shots.split(',')
    @text_shots.each do |text_shot|
      shot_to_frames(text_shot)
    end
  end

  def <<(shot_score)
    shot_to_frames(shot_score)
  end

  private

  def shot_to_frames(text_shot)
    shot = Shot.new
    shot.process_strike(text_shot)
    @score += shot.score

    shot_to_frame(shot)
    add_extra_scores(shot)

    @shots << shot
  end

  def shot_to_frame(shot)
    if @frames.count < FINAL_FRAME                      # 最終フレーム以外
      if @shots.count.zero? || @shots.last.end_of_frame # 1投目
        @frames << Frame.new(shot)
      else                                              # ２投目
        shot.end_of_frame = true
        @frames.last << shot
      end
    else
      @frames.last << shot
    end
  end

  def add_extra_scores(shot)
    add_extra_score(PREVIOUS_FRAME, shot)
    add_extra_score(ONE_BEFORE_LAST_FRAME, shot)
  end

  def add_extra_score(reference_number, shot)
    return unless @frames.count > reference_number.abs && !@frames[reference_number - 1].remaining_shots.zero?

    @frames[reference_number - 1].score += shot.score
    @frames[reference_number - 1].remaining_shots -= 1
    @score += shot.score
  end
end
