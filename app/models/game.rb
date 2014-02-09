class Game < ActiveRecord::Base

  has_many :tributes
  has_many :citizens
  has_many :rounds 

  def create_round
    round = Round.create(game_id: self.id)
    round.citizens << self.citizens.where(alive: true)
    if round.citizens.count > 3
      self.kill_half!(round.citizens)
    else
      self.three_left(round.citizens)
    end 
  end

  def kill_half!(tributes)
    shuffled_tributes_left = tributes.shuffle
    tributes_a = []
    tributes_b = []    
  
    shuffled_tributes_left.each_with_index do |tribute, i|
      ##odds go into A, evens go into B##
      if i % 2 != 0 
        @tributes_a << tribute
      else
        @tributes_b << tribute
      end    
    end
   
    tributes_a.count.times { |i|
      a=tributes_a[i]
      b=tributes_b[i]
      self.rating_battle(a, b)
    }
  end

  def three_left(tributes)
    self.sponsor_battle(tributes[0], tributes[1])
    self.sponsor_battle(tributes[1], tributes[2])
    self.sponsor_battle(tributes[0], tributes[2])
    self.game_winner
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
      self.district_battle(a, b)
    end
  end

  def district_battle(a, b)
    if a.district_id < b.district_id
      b.alive = false
      b.save
    elsif a.district_id > b.district_id
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

  def game_winner
    winner = self.citizens.where(alive: true)[0]
    victor = winner.becomes Victor 
    puts "The victor is #{victor.name} from disctrict #{victor.district_id}!"
  end


end
