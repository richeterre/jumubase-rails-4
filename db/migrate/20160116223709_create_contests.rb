class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.integer :season, null: false
      t.integer :level, null: false
      t.integer :host_id, null: false
      t.date :begins, null: false
      t.date :ends, null: false
      t.date :certificate_date
      t.datetime :signup_deadline, null: false

      t.timestamps null: false
    end
  end
end
