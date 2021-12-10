#!/usr/bin/env ruby
# frozen_string_literal: true

# フレームの数を定義
NUMBER_OF_FRAMES = 10
STRIKE = 'X'
STRIKE_SCORE = 10

shot_i = 0      # 該当するショットのインデックス
score = 0       # フレームのスコア
strikes = []    # 該当するショットがストライクかを記憶
frames = []     # 各フレームのスコア

# コマンドの引数を取得し、コンマで分割
scores = ARGV[0].split(',')

# scoresの「X」をstrikesに記憶し、scoresを10に修正
scores.each_index do |i|
  if scores[i] == STRIKE
    strikes[i] = 1
    scores[i] = STRIKE_SCORE
  else
    strikes[i] = 0
    scores[i] = scores[i].to_i
  end
end

# 各フレームのスコアを求める
NUMBER_OF_FRAMES.times do
  score = scores[shot_i]            # まずそのショットのスコアをカウント
  unless scores[shot_i + 1].nil?    # ストライクか否かにかかわらず、次のショットがあればスコアを追加
    score += scores[shot_i + 1]
    # ストライクまたはスペアで2つ先のショットがあればスコアを追加
    score += scores[shot_i + 2] if !scores[shot_i + 2].nil? && score >= 10
  end
  shot_i += (2 - strikes[shot_i])   # ストライクの場合は次のショット、それ以外は2ショット先に移動する
  frames << score                   # framesにスコアを追加
end

puts frames.sum                     # 各フレームの合計スコアを出力
