class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name, null: false
      t.string :city, null: false
      t.string :country_code, null: false
      t.string :time_zone, null: false

      t.timestamps null: false
    end
  end
end
