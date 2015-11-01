class CreateMesinProfiles < ActiveRecord::Migration
  def up 
    create_table :mesin_profiles do |t|
      t.integer :profile_id, limit: 8, null: false
      t.integer :user_id, null: false
      t.string :username, limit: 100, null: false
      t.string :fullname, default: ""
      t.date :birthdate
      t.timestamps null: false
    end

    add_index :mesin_profiles, :profile_id, unique: true
    add_index :mesin_profiles, :user_id

    execute <<-SQL
      ALTER TABLE mesin_profiles DROP CONSTRAINT mesin_profiles_pkey;
      ALTER TABLE mesin_profiles ADD CONSTRAINT mesin_profiles_pkey
        PRIMARY KEY(profile_id);
    SQL
     
    add_foreign_key :mesin_profiles, :mesin_users, column: :profile_id

  end

  def down
    drop_table :mesin_profiles
  end
end
