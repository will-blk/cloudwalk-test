# frozen_string_literal: true

require_relative "cloudwalk/version"
require_relative "cloudwalk/file/parser"

module Cloudwalk
  class Error < StandardError; end

  class Cli
    def self.run(file)
      parser = Cloudwalk::File::Parser.new(file)
      game = parser.parse

      game.report
    end
  end
end
