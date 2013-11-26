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
      f_tribute.save
    m_tribute = Citizen.where(district_id: [1,2,3,4,5,6,7,8,9,10,11,12], gender: "m", age: (12..18).to_a).sample(1)[0]
      m_tribute.type = "Tribute"
      m_tribute.game_id = self.game_id
      m_tribute.save
  end
end