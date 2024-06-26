# frozen_string_literal: true

RSpec.describe Cloudwalk do
  it "has a version number" do
    expect(Cloudwalk::VERSION).not_to be nil
  end

  describe ".run" do
    subject(:run) { described_class::Test.run("spec/fixtures/logs/file_4.log") }

    let(:report1) do
      {
        "game_1" => {
          total_kills: 14,
          players: ["Dono da Bola", "Isgalamido", "Zeh", "Assasinu Credi"],
          kills: {
            "Assasinu Credi" => 5,
            "Isgalamido" => 2,
            "Zeh" => 2
          },
          kills_by_means: {
            "MOD_RAILGUN" => 1,
            "MOD_ROCKET" => 4,
            "MOD_ROCKET_SPLASH" => 4,
            "MOD_TRIGGER_HURT" => 5
          }
        }
      }
    end

    let(:report2) do
      {
        "game_2" => {
          total_kills: 29,
          players: [
            "Fasano Again",
            "Oootsimo",
            "Isgalamido",
            "Zeh",
            "Dono da Bola",
            "UnnamedPlayer",
            "Maluquinho",
            "Assasinu Credi",
            "Mal"
          ],
          kills: {
            "Assasinu Credi" => 1,
            "Dono da Bola" => 2,
            "Isgalamido" => 4,
            "Maluquinho" => 1,
            "Oootsimo" => 9,
            "Zeh" => 8
          },
          kills_by_means: {
            "MOD_FALLING" => 1,
            "MOD_MACHINEGUN" => 1,
            "MOD_RAILGUN" => 2,
            "MOD_ROCKET" => 5,
            "MOD_ROCKET_SPLASH" => 13,
            "MOD_SHOTGUN" => 4,
            "MOD_TRIGGER_HURT" => 3
          }
        }
      }
    end

    let(:expected_report) { [report1, report2] }

    it "return the game status" do
      expect(run).to eq(expected_report)
    end
  end
end
