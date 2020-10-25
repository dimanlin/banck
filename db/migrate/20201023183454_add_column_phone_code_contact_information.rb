class AddColumnPhoneCodeContactInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_informations, :phone_code, :integer
  end
end
