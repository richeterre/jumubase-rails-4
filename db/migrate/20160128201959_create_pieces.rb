class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.references :performance, index: true, foreign_key: true, null: false
      t.string :title, null: false
      t.string :composer_name, null: false
      t.string :composer_born
      t.string :composer_died
      t.string :epoch, null: false
      t.integer :minutes, null: false
      t.integer :seconds, null: false

      t.timestamps null: false
    end
  end
end
