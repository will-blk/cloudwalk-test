# frozen_string_literal: true

require_relative "player"

module Cloudwalk
  module Model
    class Match
      attr_reader :id, :players, :kills, :world_kills, :kills_by_means

      def initialize(id)
        @id = id
        @players = []
        @world_kills = 0
        @kills = Hash.new(0)
        @kills_by_means = Hash.new(0)
      end

      def add_player(player)
        @players << player unless players.include?(player)
      end

      def add_kill(killer, killed, weapon)
        handle_death_causes(weapon)
        return add_world_kill(killed) if killer.name == "<world>"

        handle_kill(killer, killed)
      end

      def report
        {
          "game_#{id}" => {
            total_kills: total_kills,
            players: players.map(&:name),
            kills: kills,
            kills_by_means: kills_by_means
          }
        }
      end

      def total_kills
        kills.values.sum + world_kills
      end

      private

      def handle_death_causes(weapon)
        @kills_by_means[weapon] += 1
      end

      def add_world_kill(killed)
        @world_kills += 1

        killed.add_death
      end

      def handle_kill(killer, killed)
        kills[killer.name] += 1

        killer.add_kill
        killed.add_death
      end
    end
  end
end
