class Round < ActiveRecord::Base

  belongs_to :game
  has_and_belongs_to_many :citizens

end