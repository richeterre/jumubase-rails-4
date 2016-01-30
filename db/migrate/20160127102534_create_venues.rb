class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.references :host, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
