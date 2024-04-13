# frozen_string_literal: true

require_relative "player"

module Cloudwalk
  class Match
    attr_reader :id, :players, :world_kills

    def initialize(id)
      @id = id
      @players = []
      @world_kills = 0
    end

    def add_player(player)
      @players << player unless players.include?(player)
    end

    def add_kill(killer, killed)
      return add_world_kill(killed) if killer.name == "<world>"

      killer.add_kill
      killed.add_death
    end

    def report
      {
        "game_#{id}" => {
          total_kills: total_kills,
          players: players.map(&:name),
          kills: kills
        }
      }
    end

    def kills
      players.each_with_object({}) do |player, kills|
        kills[player.name] = player.kills
      end
    end

    def total_kills
      kills.values.sum + world_kills
    end

    private

    def add_world_kill(killed)
      @world_kills += 1
      killed.add_death
    end
  end
end
