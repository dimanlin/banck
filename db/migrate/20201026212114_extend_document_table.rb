class ExtendDocumentTable < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :number, :string
    add_column :documents, :expired_at, :date
  end
end
