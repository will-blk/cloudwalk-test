# frozen_string_literal: true

RSpec.describe Cloudwalk do
  it "has a version number" do
    expect(Cloudwalk::VERSION).not_to be nil
  end

  it "does something useful" do
    game = Cloudwalk::Parser.new("spec/fixtures/quake.log").parse
    byebug
  end
end
