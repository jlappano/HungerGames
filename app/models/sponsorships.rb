class Sponsorships < ActiveRecord::Base
  belongs_to :tribute
  belongs_to :sponsor
end