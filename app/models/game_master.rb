class GameMaster
  def initialize(param)
    @game = Game.create(name: param)
  end

  def game
    @game
  end

  def choose_tributes
    ["m", "f"].each do |x|
      tribute = Citizen.where(district_id: (1..12).to_a, gender: x, age: (12..18).to_a).sample(1)[0]
      tribute.type = "Tribute"
      tribute.game_id = self.game.id
      tribute.rating = (1..12).to_a.sample
      tribute.save
      tribute = tribute.becomes Tribute
    end  
  end

  def get_sponsors 
    @sponsors = Citizen.where(type: "Sponsor")
    game.tributes.each do |tribute|
      tribute.sponsorships << Sponsorship.create(sponsor_id: @sponsors.sample(1)[0].id, tribute_id: tribute.id)
    end
  end
end