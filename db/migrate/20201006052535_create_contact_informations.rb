class CreateContactInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_informations do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.date :dob
      t.integer :user_id

      t.timestamps
    end
  end
end
