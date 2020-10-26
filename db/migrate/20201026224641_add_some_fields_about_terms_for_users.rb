class AddSomeFieldsAboutTermsForUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :over_18, :boolean
    add_column :users, :agree_with_terms, :boolean
  end
end
