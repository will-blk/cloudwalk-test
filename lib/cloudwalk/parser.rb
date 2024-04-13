# frozen_string_literal: true

require_relative "game"

module Cloudwalk
  class Parser
    attr_reader :game, :file
    attr_accessor :current_match

    def initialize(file)
      @file = file
      @game = Game.new
    end

    def parse
      File.open(file, "r:,iso-8859-1").each do |line|
        case line
        when /InitGame/
          p line
          @current_match = game.create_match
        when /ClientUserinfoChanged/
          p line
          player_name = line.match(/n\\([^\\]+)/)[1]
          player = game.find_or_create_player(player_name)
          current_match.add_player(player)
        when /Kill/
          p line
          killer, killed = line.match(/(\w+|<world>) killed (\w+)/)[1, 2]
          killer_player = game.find_or_create_player(killer)
          killed_player = game.find_or_create_player(killed)
          current_match.add_kill(killer_player, killed_player)
        end
      end

      game
    end
  end
end
