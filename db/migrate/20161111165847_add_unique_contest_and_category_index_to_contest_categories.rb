class AddUniqueContestAndCategoryIndexToContestCategories < ActiveRecord::Migration
  def change
    add_index :contest_categories, [:contest_id, :category_id], unique: true
  end
end
