class CreateRoundsTributes < ActiveRecord::Migration
  def change
    create_table :rounds_tributes do |t|
      t.belongs_to :round
      t.belongs_to :tribute
    end
  end
end
