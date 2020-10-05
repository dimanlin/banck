class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.column :user_id, :integer
      t.column :city, :string
      t.column :country, :string
      t.column :address, :string
      t.column :postal_code, :integer
      t.timestamps
    end
  end
end
