class AddFieldNextPhoneNumberAndnextEmailToContactInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_informations, :next_email, :string
    add_column :contact_informations, :next_phone_number, :string
    add_column :contact_informations, :email_code, :integer
    add_column :contact_informations, :sms_code, :integer
    remove_column :users, :sms_code, :integer
  end
end
