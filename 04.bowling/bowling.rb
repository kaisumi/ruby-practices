#!/usr/bin/env ruby
# frozen_string_literal: true

NUMBER_OF_FRAMES = 10
STRIKE = 'X'
STRIKE_SCORE = 10

text_scores = ARGV[0].split(',')

strikes = []
scores =
  text_scores.map.with_index do |score, i|
    if score == STRIKE
      strikes[i] = 1
      STRIKE_SCORE
    else
      strikes[i] = 0
      score.to_i
    end
  end

shot_idx = 0
frames = []
NUMBER_OF_FRAMES.times do             # フレームごとにスコアを加算。ストライク：3ショット、スペア：3ショット、その他：2ショット
  score = scores[shot_idx]            # 1ショット目
  unless scores[shot_idx + 1].nil?
    score += scores[shot_idx + 1]     # 2ショット目
    score += scores[shot_idx + 2] if !scores[shot_idx + 2].nil? && score >= 10 # 3ショット目（この時点で、> 10（ストライク）、== 10（スペア）の場合）
  end
  shot_idx += (2 - strikes[shot_idx]) # 次のフレームの先頭に移動（ストライクの場合は次のショット、それ以外は2ショット先）
  frames << score
end

puts frames.sum
