# frozen_string_literal: true

require_relative 'game'

def bowling_object(text_scores)
  game = Game.new(text_scores)
  game.score
end
