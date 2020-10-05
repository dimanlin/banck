class AddRegColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    create_table(:users) do |t|
      t.boolean :aml_rules
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.date :dob
      t.integer :sms_code
      t.integer :country
      t.integer :nationality
      t.integer :postal_code
      t.integer :country_document
      t.string :document_type
      t.string :document_number
      t.date :issued_at
    end
  end
end
