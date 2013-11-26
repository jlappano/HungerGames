class ChangeReferenceInCitizenBackToTributeId < ActiveRecord::Migration
  def change
     remove_column :sponsorships, :citizen_id
     add_reference :sponsorships, :tribute
  end
end
