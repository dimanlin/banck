class AddColumnPhoneNumberConfirmAtToContactInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_informations, :phone_confirm_at, :datetime
  end
end
