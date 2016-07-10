class AddEditCodeToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :edit_code, :string, index: { unique: true }, null: false
  end
end
