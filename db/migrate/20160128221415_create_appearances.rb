class CreateAppearances < ActiveRecord::Migration
  def change
    create_table :appearances do |t|
      t.references :performance, index: true, foreign_key: true, null: false
      t.references :participant, index: true, foreign_key: true, null: false
      t.references :instrument, index: true, foreign_key: true, null: false
      t.string :participant_role, null: false
      t.integer :points

      t.timestamps null: false
    end
  end
end
