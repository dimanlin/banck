class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.column :user_id, :integer
      t.column :country, :string
      t.column :document_type, :integer
      t.column :issued_at, :date
      t.timestamps
    end
  end
end
