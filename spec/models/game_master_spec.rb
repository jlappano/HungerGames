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
  
  let(:gameMaker) {GameMaster.new}
  
  describe "#create_game" do
    it "creates the game" do 
      expect(gameMaker.create_game("The Rumble")).to_not eq(nil)
    end
  end

    #it chooses randomly two citizens 

  describe '#choose_tributes' do
    let(:game) {gameMaker.create_game("The Rumble")}
    it "chooses 4 tributes" do
      mihran = Citizen.new(name:"Mihran Abrahamian", age: 15, gender:"m", district_id:1)
      julie = Citizen.new(name:"Julie Lappano", age: 12, gender:"f", district_id:2)
      raleigh = Citizen.new(name:"Raleigh Foeber", age: 16, gender:"f", district_id:3)
      tom = Citizen.new(name:"Tom Brennan", age: 16, gender:"m", district_id:4)
      gameMaker.choose_tributes
      expect(game.tributes.count).to eq(4)
    end
  end

end