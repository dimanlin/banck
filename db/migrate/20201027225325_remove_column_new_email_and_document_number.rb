class RemoveColumnNewEmailAndDocumentNumber < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :document_number
    remove_column :users, :new_email
  end
end
