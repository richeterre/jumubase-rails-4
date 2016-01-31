class CreateContestCategories < ActiveRecord::Migration
  def change
    create_table :contest_categories do |t|
      t.references :contest, index: true, foreign_key: true, null: false
      t.references :category, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
