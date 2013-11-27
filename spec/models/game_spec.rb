require 'spec_helper'

describe Game do

  let(:gameMaker){GameMaster.new("The 74th Annual Hunger Games")}
  let(:game){gameMaker.game}

  before do 
    (1..13).to_a.each do |x|
      10.times { FactoryGirl.create(:citizen, name: Faker::Name.name, age: (12..19).to_a.sample, district_id: x) }
    end
    10.times { FactoryGirl.create(:citizen, name: Faker::Name.name, age: (18..90).to_a.sample, type: "Sponsor") }
    gameMaker.reap
    gameMaker.get_sponsors
  end

  describe "#create_round" do

    context "all the tributes are alive" do

      it "creates first round, which has 24 tributes" do 
        game.create_round
        expect(game.rounds.count).to eq(1)
        expect(game.rounds.first.citizens.count).to eq(24)
      end
    end

    context "only 12 tributes are alive" do
      before do
        2.times {game.create_round}
      end

      it "creates a second round, which has 12 tributes" do
        expect(game.rounds.last.citizens.count).to eq(12)
      end
    end

    context "6 remain" do
      before do
        3.times {game.create_round}
      end

      it "creates a third round, which has 6 tributes" do
        expect(game.rounds.last.citizens.count).to eq(6)
      end
    end
  end


  describe "#Kill_half!" do

    #it pairs the tributes together randomly 

    #it compares the ratings of both tributes

    #IF TIE compares the num of sponsors

    #IF TIE lower num disctrict survives

    #IF TIE female survives

  end

end