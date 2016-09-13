class CreateYodleeAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :yodlee_accounts do |t|
      t.string :username
      t.string :password
      t.integer :user_id

      t.timestamps
    end
  end
end
