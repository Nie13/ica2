class AddSickAndNeedToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :sickness, :string
    add_column :accounts, :need_help, :string
  end
end
