class AddFkToCitizens < ActiveRecord::Migration
  def change
  end


  reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE citizens
          ADD CONSTRAINT fk_games
          FOREIGN KEY (game_id)
          REFERENCES games(id)
        SQL
      end
   end
end
