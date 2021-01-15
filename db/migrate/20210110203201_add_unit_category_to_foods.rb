class AddUnitCategoryToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :unit, :string
    add_column :foods, :category, :string
  end
end
