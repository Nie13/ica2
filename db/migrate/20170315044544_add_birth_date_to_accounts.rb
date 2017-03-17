class AddBirthDateToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :birth_date, :string
  end
end
