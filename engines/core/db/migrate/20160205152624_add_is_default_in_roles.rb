class AddIsDefaultInRoles < ActiveRecord::Migration
  def up 
    add_column :mesin_roles, :is_default, :boolean, default: false, null: false
  end

  def down    
    remove_column :mesin_roles, :is_default
  end
end
