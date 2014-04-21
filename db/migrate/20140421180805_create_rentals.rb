class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.string :title
      t.integer :num_bedrooms, null: false
      t.integer :num_bathrooms, null: false
      t.integer :sq_footage, null: false
      t.integer :monthly_rent, null: false
      t.text :description
      t.integer :owner_id, null: false

      t.timestamps
    end

    add_index :rentals, :num_bedrooms
    add_index :rentals, :num_bathrooms
    add_index :rentals, :monthly_rent
    add_index :rentals, :owner_id
  end
end
