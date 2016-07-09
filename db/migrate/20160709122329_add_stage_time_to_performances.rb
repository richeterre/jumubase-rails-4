class AddStageTimeToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :stage_time, :datetime
  end
end
