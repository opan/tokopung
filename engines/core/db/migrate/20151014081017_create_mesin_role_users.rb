class CreateMesinRoleUsers < ActiveRecord::Migration
  def up
    create_table :mesin_role_users do |t|
      t.integer :role_id, null: false
      t.integer :user_id
      t.timestamps null: false
    end

    add_index :mesin_role_users, [:role_id, :user_id], unique: true
    add_foreign_key :mesin_role_users, :mesin_users, column: :user_id, primary_key: :id
    add_foreign_key :mesin_role_users, :mesin_roles, column: :role_id, primary_key: :id
  end

  def down
    drop_table :mesin_role_users
  end
end
