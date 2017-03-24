class ChangeBirthDateFormatInAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :birth_date, :date
  end
end
