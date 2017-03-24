class CreateWorkerFiles < ActiveRecord::Migration
  def change
    create_table :worker_files do |t|
      t.string :name
      t.string :doc_type
      t.references :worker, references: :worker_applies, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
