class RemoveAddressColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :country
    remove_column :users, :postal_code
  end
end
