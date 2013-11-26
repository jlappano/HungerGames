class ChangeReferenceInSponsorships < ActiveRecord::Migration
  def change
     remove_column :sponsorships, :tribute_id
     add_reference :sponsorships, :citizen
  end
end
