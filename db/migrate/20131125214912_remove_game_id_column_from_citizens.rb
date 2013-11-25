class RemoveGameIdColumnFromCitizens < ActiveRecord::Migration
  def change
    remove_column :citizens, :game_id
  end
end
