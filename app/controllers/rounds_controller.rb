class RoundsController < ApplicationController
  def create
  end

  def show
    @game_master = GameMaster.new("The 74th annual Hunger Games")
    @game = @game_master.game
    
  end

end