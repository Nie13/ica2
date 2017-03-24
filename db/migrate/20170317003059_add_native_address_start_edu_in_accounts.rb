class AddNativeAddressStartEduInAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :start_time, :date
    add_column :accounts, :native_place, :string
    add_column :accounts, :edu_level, :string
    add_column :accounts, :home_address, :string
    add_column :accounts, :fastable, :boolean, default: false
    add_column :accounts, :salary_level, :string
  end
end
