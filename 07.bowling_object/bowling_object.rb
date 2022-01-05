# frozen_string_literal: true

require_relative 'game'

def bowling_object(text_scores)
  game = Game.new
  game.text_to_score(text_scores)
  game.score
end

# bowling_object(ARGV[0])
