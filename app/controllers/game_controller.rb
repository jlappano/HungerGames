class GameController < ApplicationController
  def index
    @game_master = GameMaster.new("The 74th annual Hunger Games")
  end
end