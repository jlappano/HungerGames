require 'spec_helper'

describe GameMaster do

  #it chooses randomly two citizens 
    #two citizens per district
    #one male, one female
    #ages 12 - 18
  #it assigns a game_id
  #assigns an escort
  #assigns a rating
  #adds sponsors

  #it creates a game
  
  let(:gameMaker) {GameMaster.new("The Rumble")}
  
  describe "#create_game" do
    it "creates the game" do 
      expect(gameMaker.game).to_not eq(nil)
    end
  end

    #it chooses randomly two citizens 

  describe '#choose_tributes' do
    before do 
      mihran = Citizen.create(name:"Mihran Abrahamian", age: 15, gender: "m", district_id:1)
      julie = Citizen.create(name:"Julie Lappano", age: 12, gender:"f", district_id:2)
      raleigh = Citizen.create(name:"Raleigh Foeber", age: 16, gender:"f", district_id:14)
      tom = Citizen.create(name:"Tom Brennan", age: 16, gender:"m", district_id:15)
      harry = Citizen.create(name:"Harry Potter", age: 12, gender:"m", district_id:16)
      pj = Citizen.create(name:"PJ hughes", age: 16, gender:"m", district_id:2)
      frank = Citizen.create(name:"Frank Baum", age: 17, gender:"m", district_id:2)
      jeff = Citizen.create(name:"Jeff Baum", age: 17, gender:"m", district_id:4)
    end 

    let(:game) {gameMaker.game}

    it "chooses 2 random tributes" do
      gameMaker.choose_tributes
      expect(game.tributes.count).to eq(2)
    end

    it "only chooses citizens from districts 1-12" do
      gameMaker.choose_tributes
      #game.tributes == [#<Tribute id: 192, name: "Mihran Abrahamian", age: 15, gender: "m", type: "Tribute", alive?: true, district_id: 1, rating: nil, game_id: 79>,
      #<Tribute id: 193, name: "Julie Lappano", age: 12, gender: "f", type: "Tribute", alive?: true, district_id: 2, rating: nil, game_id: 79>]
      expect(game.tributes[0].district_id).to be <= 12
      expect(game.tributes[1].district_id).to be <= 12
    end

    it "chooses one male and one female" do
      gameMaker.choose_tributes
      expect([game.tributes[0].gender, game.tributes[1].gender]).to match_array(["m", "f"])
    end

    it "chooses only from ages 12 - 18" do
      gameMaker.choose_tributes
      expect((12..18).to_a).to include((game.tributes[0].age), (game.tributes[1].age))
    end

    it "assigns a rating randomly to each tribute" do
      gameMaker.choose_tributes
      expect(game.tributes[0].rating).to_not be(nil)
      expect(game.tributes[1].rating).to_not be(nil)

    end
  end

end