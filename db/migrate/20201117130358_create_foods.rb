class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :place
      t.string :quantity
      t.date :purchase_date
      t.references :family, foreign_key: true

      t.timestamps
    end
  end
end
