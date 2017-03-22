class DropWorkerDocUploader < ActiveRecord::Migration
  def change
    drop_table :worker_docs
  end
end
