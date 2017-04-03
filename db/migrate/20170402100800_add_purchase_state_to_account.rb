class AddPurchaseStateToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :lt_purchase_state, :integer, default: 0
    add_column :accounts, :qh_purchase_state, :integer, default: 0
  end
end
