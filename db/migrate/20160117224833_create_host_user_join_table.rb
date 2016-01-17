class CreateHostUserJoinTable < ActiveRecord::Migration
  def change
    create_join_table :hosts, :users do |t|
      t.index [:host_id, :user_id], unique: true
      t.index :user_id
    end
  end
end
