class RenameLevelToRound < ActiveRecord::Migration
  def change
    rename_column :contests, :level, :round
  end
end
