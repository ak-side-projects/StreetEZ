class AddActiveColumnToSavedRentalsAndAttendOpenHouse < ActiveRecord::Migration
  def change
    add_column :saved_rentals, :active, :boolean, default: true
    add_column :attend_open_houses, :active, :boolean, default: true
  end
end
