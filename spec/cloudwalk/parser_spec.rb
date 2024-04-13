# frozen_string_literal: true

RSpec.describe Cloudwalk::Parser do
  subject(:parser) { described_class.new("spec/fixtures/logs/#{file}") }

  describe "#parse" do
    context "with a single player and no kills" do
      subject(:game) { parser.parse }

      let(:file) { "file_1.log" }

      it "returns a game instance" do
        expect(game).to be_a(Cloudwalk::Game)
      end

      it "has the correct number of kills" do
        expect(game.matches.first.total_kills).to eq(0)
      end

      it "has the correct players" do
        expect(game.players.keys).to eq(["Isgalamido"])
      end

      it "has a single match" do
        expect(game.matches.size).to eq(1)
      end
    end


    context "with multiple players and kills" do
      subject(:game) { parser.parse }

      let(:file) { "file_2.log" }

      it "has the correct number of kills" do
        expect(game.matches.first.total_kills).to eq(11)
      end

      it "has the correct players" do
        expect(game.players.keys).to eq(["Isgalamido", "Dono da Bola", "Mocinha"])
      end

      it "has correct kills count" do
        expect(game.matches.first.kills).to eq(
          {
            "Dono da Bola" => 0,
            "Isgalamido" => 3,
            "Mocinha" => 0
          }
        )
      end
    end
  end
end
