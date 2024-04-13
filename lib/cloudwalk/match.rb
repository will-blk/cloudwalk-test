# frozen_string_literal: true

module Cloudwalk
  class Match
    attr_reader :id, :players, :kills

    def initialize(id)
      @id = id
      @players = []
      @kills = Hash.new(0)
    end

    def add_player(player)
      @players << player
    end

    def add_kill(player)
      kills[player] += 1
    end

    def report
      {
        game_id: {
          total_kills: total_kills,
          players: players.map(&:name),
          kills: kills
        }
      }
    end

    private

    def total_kills
      kills.values.sum
    end
  end
end
