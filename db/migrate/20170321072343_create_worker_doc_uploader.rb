class CreateWorkerDocUploader < ActiveRecord::Migration
  def change
    create_table :worker_docs do |t|
      t.text :nurse
      t.text :primary_caregiver
      t.text :middle_caregiver
      t.text :high_caregiver
      t.text :standard_caregiver
      t.references :worker, references: :worker_applies, index:true
      t.timestamps null: false
    end
  end
end
