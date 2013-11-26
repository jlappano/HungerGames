class GameMaster

  def initialize(param)
    @game = Game.create(name: param)
  end

  def game
    @game
  end

  def game_id
    @game.id
  end

  def choose_tributes
    f_tribute = Citizen.where(district_id: (1..12).to_a, gender: "f", age: (12..18).to_a).sample(1)[0]
    f_tribute.type = "Tribute"
    f_tribute.game_id = self.game_id
    f_tribute.rating = (1..12).to_a.sample
    f_tribute.save
    f_tribute = f_tribute.becomes Tribute
      
    m_tribute = Citizen.where(district_id: (1..12).to_a, gender: "m", age: (12..18).to_a).sample(1)[0]
    m_tribute.type = "Tribute"
    m_tribute.game_id = self.game_id
    m_tribute.rating = (1..12).to_a.sample
    m_tribute.save
    m_tribute = m_tribute.becomes! Tribute
    @tributes = [f_tribute, m_tribute]
  end

  def get_sponsors 
    @sponsors = Citizen.where(type: "Sponsor")
    @tributes.each do |tribute|
      tribute.sponsorships = Sponsorship.create(sponsor_id: @sponsors.sample(1), tribute_id: f_tribute.id)
    end
  end
end