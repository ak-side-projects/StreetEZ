class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notifiable_id, null: false
      t.string :notifiable_type, null: false
      t.integer :event_id, null: false
      t.integer :user_id, null: false
      
      t.timestamps
    end
    
    add_index :notifications, :notifiable_id
    add_index :notifications, :notifiable_type
    add_index :notifications, :event_id
    add_index :notifications, :user_id
  end
end
