class AddIsReadColumnToNotificationsTable < ActiveRecord::Migration
  def change
    add_column :notifications, :is_read, :boolean, default: false
    add_index :notifications, :is_read
    add_column :users, :notifications_count, :integer
  end
end
