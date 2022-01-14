# frozen_string_literal: true

require_relative 'game'

def bowling_object(text_scores)
  game = Game.new(text_scores)
  game.score
end

def bowling_object_another_usage(text_scores)
  game = Game.new
  text_scores.split(',').each do |text_score|
    game << text_score
    # puts "Frame: #{game.frame_count}, Score: #{game.score}" # 出力例
  end
  game.score
end

bowling_object_another_usage('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
bowling_object('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')

# bowling_object(ARGV[0])
