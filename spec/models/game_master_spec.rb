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
      (1..12).to_a.each do |x|
        10.times { FactoryGirl.create(:citizen, name: Faker::Name.name, age: (12..18).to_a.sample, district_id: x) }
      end
      # mihran = Citizen.create(name:"Mihran Abrahamian", age: 15, gender: "m", district_id:1)
      # julie = Citizen.create(name:"Julie Lappano", age: 12, gender:"f", district_id:2)
      # raleigh = Citizen.create(name:"Raleigh Foeber", age: 16, gender:"f", district_id:14)
      # tom = Citizen.create(name:"Tom Brennan", age: 16, gender:"m", district_id:15)
      # harry = Citizen.create(name:"Harry Potter", age: 12, gender:"m", district_id:16)
      # pj = Citizen.create(name:"PJ hughes", age: 30, gender:"m", district_id:2)
      # frank = Citizen.create(name:"Frank Baum", age: 52, gender:"m", district_id:2)
      # jeff = Citizen.create(name:"Jeff Baum", age: 8, gender:"m", district_id:4)
      gameMaker.choose_tributes
    end

    describe '#choose_tributes' do

      it "chooses 2 random tributes" do
        expect(game.tributes.count).to eq(2)
      end

      it "only chooses citizens from districts 1-12" do
        #game.tributes == [#<Tribute id: 192, name: "Mihran Abrahamian", age: 15, gender: "m", type: "Tribute", alive?: true, district_id: 1, rating: nil, game_id: 79>,
        #<Tribute id: 193, name: "Julie Lappano", age: 12, gender: "f", type: "Tribute", alive?: true, district_id: 2, rating: nil, game_id: 79>]
        expect(game.tributes[0].district_id).to be <= 12
        expect(game.tributes[1].district_id).to be <= 12
      end

      it "chooses one male and one female" do
        expect([game.tributes[0].gender, game.tributes[1].gender]).to match_array(["m", "f"])
      end

      it "chooses only from ages 12 - 18" do
        expect((12..18).to_a).to include((game.tributes[0].age), (game.tributes[1].age))
      end

      it "asigns a rating randomly to each tribute" do
        expect(game.tributes[0].rating).to_not be(nil)
        expect(game.tributes[1].rating).to_not be(nil)
      end

      describe '#get_sponsors' do

        before do 
          10.times { FactoryGirl.create(:citizen, name: Faker::Name.name, age: (18..90).to_a.sample, type: "Sponsor") }
          # sponsor_1 = Citizen.create(name:"Rich Uncle Phil", type: "Sponsor", district_id:4)
          # sponsor_2 = Citizen.create(name:"Rich Uncle Doug", type: "Sponsor", district_id:2)
          # sponsor_3 = Citizen.create(name:"Rich Aunt Bedelia", type: "Sponsor", district_id:1)
          # sponsor_4 = Citizen.create(name:"Rich Aunt Peggy", type: "Sponsor", district_id:1)
        end 

        it "assigns sponsorships to each tribute" do
          gameMaker.get_sponsors
          expect(game.tributes[0].sponsorships.empty?).to be_false
          expect(game.tributes[1].sponsorships.empty?).to be_false
        end
      end
    end
  end
end