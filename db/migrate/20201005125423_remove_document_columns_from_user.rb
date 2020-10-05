class RemoveDocumentColumnsFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :country_document
    remove_column :users, :document_type
    remove_column :users, :issued_at
  end
end
