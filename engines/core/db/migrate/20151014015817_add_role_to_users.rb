class AddRoleToUsers < ActiveRecord::Migration
  def up
    add_column :mesin_users, :role, :integer, null: false

    # add_foreign_key :mesin_users, :mesin_roles, column: :role, primary_key: :id, on_delete: :restrict, on_update: :restrict
    add_index :mesin_users, :role
  end

  def down
    # remove_foreign_key :mesin_users, column: :role
    remove_index :mesin_users, :role

    remove_column :mesin_users, :role
  end
end
