class GameController < ApplicationController
  def index
    @game_master = GameMaster.new("The 74th annual HUnger Games")
  end
end