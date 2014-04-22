class AddNeighborhoodToRentalAndRemoveFromAddress < ActiveRecord::Migration
  def change
    add_column :rentals, :neighborhood, :string, null: false
    remove_column :addresses, :neighborhood
  end
end
