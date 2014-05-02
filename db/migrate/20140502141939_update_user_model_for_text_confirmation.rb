class UpdateUserModelForTextConfirmation < ActiveRecord::Migration
  def change
    add_column :users, :mobile_number, :string
    add_column :users, :text_confirmation_code, :string
    add_column :users, :is_confirmed, :boolean, default: false
  end
end
