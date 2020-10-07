class ChangeColumnTypeForNationality < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :nationality, :string
  end
end
