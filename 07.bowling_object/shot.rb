# frozen_string_literal: true

FULL_SCORE = 10
EMPTY_SCORE = 0

class Shot
  def initialize(text_shot = '')
    @text_shot = text_shot
  end

  def score
    case @text_shot
    when 'X'
      FULL_SCORE
    when ''
      EMPTY_SCORE
    else
      @text_shot.to_i
    end
  end
end
