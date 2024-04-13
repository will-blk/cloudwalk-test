# frozen_string_literal: true

require_relative "match"
require_relative "player"

module Cloudwalk
  class Game
    attr_reader :matches, :players

    def initialize
      @matches = []
      @players = {}
      @world = Struct.new(:name).new("<world>")
    end

    def create_match
      match = Match.new(matches.size + 1)
      matches << match

      match
    end

    def find_player(player_name)
      return @world if player_name == "<world>"

      players[player_name]
    end

    def find_or_create_player(player_name)
      find_player(player_name) || players[player_name] = Player.new(player_name)
    end

    def report
      matches.map(&:report)
    end
  end
end
