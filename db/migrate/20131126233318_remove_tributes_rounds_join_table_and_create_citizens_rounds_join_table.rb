class RemoveTributesRoundsJoinTableAndCreateCitizensRoundsJoinTable < ActiveRecord::Migration
  def change
    drop_table :rounds_tributes
    create_table :citizens_rounds do |t|
      t.references :citizen
      t.references :round
    end
  end
end
