class RemoveColumnsAboutAddressFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :phone_number
    remove_column :users, :dob
  end
end
