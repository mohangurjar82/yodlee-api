class AddYodleeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :yodlee_username, :string
    add_column :users, :yodlee_password, :string
  end
end
