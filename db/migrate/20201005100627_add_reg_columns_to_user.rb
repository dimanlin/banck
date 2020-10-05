class AddRegColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    create_table(:users) do |t|
      t.boolean :aml_rules
      t.string :first_name
      t.string :last_name
      t.string :phonenumber
      t.date :dob
      t.integer :sms_code
      t.integer :country, default: 0
      t.integer :nationality, default: 0
      t.integer :postal_code
      t.integer :country_document, default: 0
      t.string :document_type, default: 0
      t.string :document_number, :string
      t.date :issued_at
    end
  end
end
