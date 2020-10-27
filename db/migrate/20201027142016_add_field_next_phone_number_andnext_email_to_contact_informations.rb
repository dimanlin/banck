class AddFieldNextPhoneNumberAndnextEmailToContactInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :new_email, :string
    add_column :contact_informations, :new_phone_number, :string
    add_column :users, :email_code, :integer
    add_column :contact_informations, :sms_code, :integer
    remove_column :users, :sms_code, :integer
  end
end
