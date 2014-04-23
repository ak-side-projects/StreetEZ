class AddActiveColumnToModels < ActiveRecord::Migration
  def change
    add_column :rentals, :active, :boolean, default: true
    add_column :open_houses, :active, :boolean, default: true
  end
end
