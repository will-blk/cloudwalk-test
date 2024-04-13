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
        expect(game.players.keys).to contain_exactly("Isgalamido", "Dono da Bola", "Mocinha")
      end

      it "has correct kills count" do
        expect(game.matches.first.kills).to eq(
          {
            "Isgalamido" => 3
          }
        )
      end
    end

    context "with multiple matches" do
      subject(:game) { parser.parse }

      let(:file) { "file_3.log" }

      it "has the correct number of kills on each match" do
        expect(game.matches.map(&:total_kills)).to eq([4, 105])
      end

      it "has the correct players for all matches" do
        expect(game.players.keys).to contain_exactly("Isgalamido", "Dono da Bola", "Mocinha", "Zeh", "Assasinu Credi")
      end

      it "has correct kills count per player for all matches" do
        expect(game.matches.map(&:kills)).to eq(
          [
            {
              "Isgalamido" => 1
            },
            {
              "Dono da Bola" => 20,
              "Isgalamido" => 27,
              "Zeh" => 22,
              "Assasinu Credi" => 16
            }
          ]
        )
      end
    end
  end
end
