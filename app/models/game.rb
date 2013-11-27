class Game < ActiveRecord::Base

  has_many :tributes
  has_many :citizens
  has_many :rounds 

  def create_round
    round = Round.create(game_id: self.id)
    round.citizens << self.citizens.where(alive: true)
    if self.citizens.where(alive: true).count > 3
      get_into_pairs
    else
      fourth_round
    end 
  end

  def live_tributes
    self.citizens.where(alive: true)
  end

  def get_into_pairs
    shuffled_tributes_left = live_tributes.shuffle
    @tributes_a = []
    @tributes_b = []    

    shuffled_tributes_left.each_with_index do |tribute, i|
      ##odds go into A, evens go into B##
      if i % 2 != 0 
        @tributes_a << tribute
      else
        @tributes_b << tribute
      end    
    end
    fight_to_the_death!
  end

  def fight_to_the_death!
    i = 0
    @tributes_a.count.times do
      a=@tributes_a[i]
      b=@tributes_b[i]

      if a.rating > b.rating
        b.alive = false
      elsif b.rating > a.rating
        a.alive = false
      elsif (a.rating == b.rating) 
        if (a.sponsors.count> b.sponsors.count)
          b.alive = false
        elsif (b.sponsors.count> a.sponsors.count)
          a.alive = false
        elsif (a.sponsors.count == b.sponsors.count)
          if a.district_id == b.district_id
            male = Tribute.where(district_id: a.district_id, gender:"m")
            male.alive = false
            male.save
          elsif a.district_id > b.district_id
            a.alive = false
          elsif b.district_id > a.district_id
            b.alive = false
          end
        end
      end
      a.save
      b.save
      i+=1      
    end
  end

  def fourth_round

  end

end