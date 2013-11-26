require 'spec_helper'

describe GameMaster do

  let(:gameMaker) {GameMaster.new("The Rumble")}

  describe "#create_game" do
    it "creates the game" do 
      expect(gameMaker.game).to_not eq(nil)
    end
  end

  context 'choosing tributes and sponsors' do 
    
    let(:game) {gameMaker.game}
    
    before do 
      (1..13).to_a.each do |x|
        10.times { FactoryGirl.create(:citizen, name: Faker::Name.name, age: (12..19).to_a.sample, district_id: x) }
      end
      gameMaker.reap
    end

    describe '#reap' do

      it "only chooses citizens from districts 1-12" do
        expect(game.tributes[0].district_id).to be <= 12
        expect(game.tributes[1].district_id).to be <= 12
      end

      it "chooses equal numbers of male and female tributes" do
        expect(game.tributes.where(gender: "f").count).to eq(game.tributes.where(gender: "m").count)
      end

      it "chooses only from ages 12 - 18" do
        expect((12..18).to_a).to include((game.tributes[0].age), (game.tributes[1].age))
      end

      it "asigns a rating randomly to each tribute" do
        # expect(game.tributes[0].rating).to_not be(nil)
        # expect(game.tributes[1].rating).to_not be(nil)
        expect((game.tributes.map {|tribute| tribute.rating}).include?(0)).to be_false
      end

      it "reaps a total of 24 tributes" do
        expect(game.tributes.length).to eq(24)
      end

      describe '#get_sponsors' do

        before do 
          10.times { FactoryGirl.create(:citizen, name: Faker::Name.name, age: (18..90).to_a.sample, type: "Sponsor") }
        end 

        it "assigns sponsorships to each tribute" do
          gameMaker.get_sponsors
          binding.pry
          expect((game.tributes.map {|tribute| tribute.sponsorships.count}).uniq).to match_array [0,1,2,3]          
          # expect(game.tributes[0].sponsorships.count).to be <= 3 
          # expect(game.tributes[1].sponsorships.count).to be <= 3
        end
      end
    end
  end
end