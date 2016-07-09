class AddStageVenueIdToPerformances < ActiveRecord::Migration
  def change
    add_reference :performances, :stage_venue, index: true
  end
end
