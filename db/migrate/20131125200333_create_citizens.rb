class CreateCitizens < ActiveRecord::Migration
  def change
    create_table :citizens do |t|
      t.string :name
      t.integer :age
      t.string :gender 
      t.string :type, index: true  
      t.boolean :alive?, default: true
      t.belongs_to :district
    end
  end
end
