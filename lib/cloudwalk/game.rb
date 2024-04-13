# frozen_string_literal: true

require_relative "match"
require_relative "player"

module Cloudwalk
  class Game
    attr_reader :matches, :players

    def initialize
      @matches = []
      @players = {}
    end

    def create_match
      match = Match.new(matches.size + 1)
      matches << match

      match
    end

    def find_or_create_player(player_name)
      players[player_name] ||= Player.new(player_name)
      players[player_name]
    end
  end
end
