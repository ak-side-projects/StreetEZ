class CreateSavedRentals < ActiveRecord::Migration
  def change
    create_table :saved_rentals do |t|
      t.integer :user_id, null: false
      t.integer :rental_id, null: false

      t.timestamps
    end

    add_index :saved_rentals, :user_id
    add_index :saved_rentals, :rental_id
  end
end
