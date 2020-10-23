class AddColumnDialNumberToContactInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_informations, :dial_code, :string
  end
end
