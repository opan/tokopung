class AddFieldRoleIdParentTableRoles < ActiveRecord::Migration
  def change
    add_column :mesin_roles, :role_id_parent, :integer, default: 0
    add_column :mesin_roles, :role_title, :string, limit: 50
  end

  def down
    remove_column :mesin_roles, :role_id_parent
    remove_column :mesin_roles, :role_title
  end
end
