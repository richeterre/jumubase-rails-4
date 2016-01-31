class AddContestCategoryToPerformances < ActiveRecord::Migration
  def change
    change_table :performances do |t|
      t.remove_references :contest, index: true, foreign_key: true, null: false
      t.references :contest_category, index: true, foreign_key: true, null: false
    end
  end
end
