class CreateAttendOpenHouses < ActiveRecord::Migration
  def change
    create_table :attend_open_houses do |t|
      t.integer :open_house_id
      t.integer :user_id
      
      t.timestamps
    end
    
    add_index :attend_open_houses, :open_house_id
    add_index :attend_open_houses, :user_id
  end
end
