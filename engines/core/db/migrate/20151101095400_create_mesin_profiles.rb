class CreateMesinProfiles < ActiveRecord::Migration
  def up 
    create_table :mesin_profiles do |t|
      t.integer :user_id
      t.string :username, limit: 100, null: false
      t.string :fullname, default: ""
      t.date :birthdate
      t.timestamps null: false
    end

    add_index :mesin_profiles, :user_id
     
    add_foreign_key :mesin_profiles, :mesin_users, column: :user_id
  end

  def down
    drop_table :mesin_profiles
  end
end
