class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :genre, null: false
      t.boolean :solo, null: false
      t.boolean :ensemble, null: false

      t.timestamps null: false
    end
  end
end
