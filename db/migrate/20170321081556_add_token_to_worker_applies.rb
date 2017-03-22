class AddTokenToWorkerApplies < ActiveRecord::Migration
  def change
    add_column :worker_applies, :access_token, :string
    add_index :worker_applies, :access_token, unique: true
  end
end
