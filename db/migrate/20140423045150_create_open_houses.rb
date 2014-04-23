class CreateOpenHouses < ActiveRecord::Migration
  def change
    create_table :open_houses do |t|
      t.integer :rental_id, null: false
      t.date :event_date, null: false
      t.time :event_time, null: false
      
      t.timestamps
    end
    
    add_index :open_houses, :rental_id
  end
end
