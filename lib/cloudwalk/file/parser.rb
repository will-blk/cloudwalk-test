# frozen_string_literal: true

require_relative "../model/game"

module Cloudwalk
  module File
    class Parser
      attr_reader :game, :file
      attr_accessor :current_match

      def initialize(file)
        @file = file
        @game = Model::Game.new
      end

      def parse
        ::File.open(file, "r:iso-8859-1").each do |line|
          case line
          when /InitGame/
            @current_match = game.create_match
          when /ClientUserinfoChanged/
            handle_player_name(line)
          when /Kill/
            handle_kill(line)
          end
        end

        game
      end

      private

      def handle_player_name(line)
        player_name = line.match(/n\\([^\\]+)/)[1]
        player = game.find_or_create_player(player_name)
        current_match.add_player(player)
      end

      def handle_kill(line)
        killer, killed, weapon = line.match(/\d: (.*) killed (.+) by (\w+)/)[1, 3]
        killer_player = game.find_player(killer)
        killed_player = game.find_player(killed)

        current_match.add_kill(killer_player, killed_player, weapon)
      end
    end
  end
end
