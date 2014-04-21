class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.string :title, null: false
      t.integer :num_bedrooms
      t.integer :num_bathrooms
      t.integer :sq_footage
      t.integer :monthly_rent
      t.text :description
      t.integer :owner_id

      t.timestamps
    end

    add_index :rentals, :num_bedrooms
    add_index :rentals, :num_bathrooms
    add_index :rentals, :monthly_rent
    add_index :rentals, :owner_id
  end
end
