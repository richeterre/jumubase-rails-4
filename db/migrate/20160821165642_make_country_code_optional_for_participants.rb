class MakeCountryCodeOptionalForParticipants < ActiveRecord::Migration
  def change
    change_column :participants, :country_code, :string, null: true
  end
end
