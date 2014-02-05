class Game < ActiveRecord::Base
  has_many :tributes
  has_many :citizens
  has_many :rounds
 

  def create_round
    round = Round.create(game_id: self.id)
    round.citizens << self.citizens.where(alive: true)
    if self.citizens.where(alive: true).count > 3
      kill_half!
    else
      three_left
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

    i = 0
    
    tributes_a.count.times do
      a=tributes_a[i]
      b=tributes_b[i]

        if a.rating > b.rating
          b.alive = false
          b.save
        elsif b.rating > a.rating
          a.alive = false
          a.save
        else
          false
        end
      i++

    end

    # self.tributes.where(alive: true).sample(self.tributes.where(alive:true).count/2).each do |tribute| 
    #   tribute.alive = false
    #   tribute.save

  end

  def three_left
    print "Three left!"
  end


end 