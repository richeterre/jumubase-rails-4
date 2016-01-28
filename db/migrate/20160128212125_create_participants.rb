class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birthdate, null: false
      t.string :street
      t.string :postal_code
      t.string :city
      t.string :country_code, null: false
      t.string :phone, null: false
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
