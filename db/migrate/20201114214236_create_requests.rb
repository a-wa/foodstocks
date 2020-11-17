class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.references :guest, foreign_key: { to_table: :users }
      t.integer :status

      t.timestamps
    end
  end
end
