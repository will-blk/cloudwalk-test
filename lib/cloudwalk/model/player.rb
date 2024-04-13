# frozen_string_literal: true

module Cloudwalk
  module Model
    class Player
      attr_reader :name, :kills, :deaths

      def initialize(name)
        @name = name
        @kills = 0
        @deaths = 0
      end

      def add_kill
        @kills += 1
      end

      def add_death
        @deaths += 1
      end

      def score
        kills - deaths
      end
    end
  end
end
