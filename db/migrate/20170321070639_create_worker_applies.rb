class CreateWorkerApplies < ActiveRecord::Migration
  def change
    create_table :worker_applies do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :phone
      t.string :email
      t.string :edu_level
      t.string :nav_place
      t.string :home_address
      t.date :start_date
      t.integer :salary_quest
      t.string :sicknesses
      t.string :helps
      t.boolean :activate
      t.boolean :ltservice
      t.boolean :qhservice
      t.date :available_from
      t.date :available_to
      t.time :begin_time
      t.time :end_time
      t.integer :status
      t.timestamps
    end
  end
end
