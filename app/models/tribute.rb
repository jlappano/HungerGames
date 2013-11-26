class Tribute < Citizen
  has_many :sponsorships
  has_many :sponsors, through: :sponsorships
end