class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.references :contest, index: true, foreign_key: true
      t.references :predecessor, index: true

      t.timestamps null: false
    end
  end
end
