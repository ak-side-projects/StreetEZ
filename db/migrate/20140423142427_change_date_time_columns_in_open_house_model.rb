class ChangeDateTimeColumnsInOpenHouseModel < ActiveRecord::Migration
  def change
    remove_column :open_houses, :event_date
    remove_column :open_houses, :event_time
    
    add_column :open_houses, :event_datetime, :datetime, null: false
  end
end
