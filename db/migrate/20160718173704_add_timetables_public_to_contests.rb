class AddTimetablesPublicToContests < ActiveRecord::Migration
  def change
    add_column :contests, :timetables_public, :boolean, null: false, default: false
  end
end
