class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :rental_id, null: false
      t.string :neighborhood, null: false
      t.string :street, null: false
      t.string :unit, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :zipcode, null: false

      t.timestamps
    end

    add_index :addresses, :rental_id
  end
end
