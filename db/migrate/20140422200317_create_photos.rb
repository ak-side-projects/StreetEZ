class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :file
      t.integer :rental_id
      t.timestamps
    end

    add_index :photos, :rental_id
  end
end
