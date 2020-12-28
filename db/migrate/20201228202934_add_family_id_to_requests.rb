class AddFamilyIdToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :family_id, :integer
  end
end
