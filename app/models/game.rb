class Game < ActiveRecord::Base
  has_many :tributes
  has_many :citizens
  has_many :rounds
 

  def create_round
    round = Round.create(game_id: self.id)
    round.citizens << self.citizens.where(alive: true)
    if self.citizens.where(alive: true).count > 3
      self.kill_half!
    else
      self.three_left
    end 
  end

  def kill_half!
    tributes_left = self.tributes.where(alive: true)
    shuffled_tributes_left = tributes_left.shuffle
    tributes_a = []
    tributes_b = []    

    shuffled_tributes_left.each_with_index do |tribute, i|
      ##odds go into A, evens go into B##
      if i % 2 != 0 
        tributes_a << tribute
      else
        tributes_b << tribute
      end    
    end
   
    tributes_a.count.times { |i|
      a=tributes_a[i]
      b=tributes_b[i]
      self.rating_battle(a, b)
    }

  end

  def three_left
    print "Three left!"
  end

  def rating_battle(a, b)
    if a.rating > b.rating
      b.alive = false
      b.save
    elsif b.rating > a.rating
      a.alive = false
      a.save
    else
      self.sponsor_battle(a, b)
    end
  end

  def sponsor_battle(a, b)
    if a.sponsorships.count > b.sponsorships.count
      b.alive = false
      b.save
    elsif a.sponsorships.count < b.sponsorships.count
      a.alive = false
      a.save
    else
      self.gender_battle(a, b)
    end
  end

  def gender_battle(a, b)
    if a.gender == "f"
      b.alive = false
      b.save
    end
  end


end 