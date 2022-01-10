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

    text_to_score(text_shots) unless text_shots.blank?
  end

  def text_to_score(text_shots)
    @text_shots = text_shots.split(',')
    @text_shots.each do |text_shot|
      shot_to_frames(text_shot)
    end
  end

  # def <<(shot_score)
  #   shot_to_frames(shot_score)
  # end

  def score
    @frames.sum(&:score)
  end

  private

  def shot_to_frames(text_shot)
    shot = Shot.new(text_shot)

    shot_to_frame(shot)
    add_extra_scores(shot)
  end

  def shot_to_frame(shot)
    if @frames.count < FINAL_FRAME
      if @frames.blank? || @frames.last.frame_ended?     # 1投目
        @frames << Frame.new(shot)
      else                                               # 2投目
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
    return if @frames[reference_number].nil?
    return if @frames[reference_number].remaining_shots.zero?

    @frames[reference_number] << shot
  end
end
