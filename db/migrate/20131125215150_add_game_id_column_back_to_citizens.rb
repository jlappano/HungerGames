class AddGameIdColumnBackToCitizens < ActiveRecord::Migration
  def change
    change_table :citizens do |t|
      t.belongs_to :game
    end
  end
end
