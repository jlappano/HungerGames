class CreateSponsership < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.belongs_to :sponsor
      t.belongs_to :tribute
    end
  end
end


