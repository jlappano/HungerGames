class Citizen < ActiveRecord::Base  

  has_and_belongs_to_many :rounds

end