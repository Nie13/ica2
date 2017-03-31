class RemoveUniqueIndexFromAccount < ActiveRecord::Migration
  def change
    remove_index :accounts, :email
    add_index :accounts, :email, :unique => false
  end
end
