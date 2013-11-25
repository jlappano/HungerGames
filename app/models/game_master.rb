class GameMaster

  def create_game(param)
    @game = Game.create(name: param)
  end

  def choose_tributes
    @tributes
  end

end