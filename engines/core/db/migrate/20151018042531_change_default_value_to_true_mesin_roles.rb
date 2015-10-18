class ChangeDefaultValueToTrueMesinRoles < ActiveRecord::Migration
  def up
    change_column :mesin_roles, :it_can_be_deleted, :boolean, null: false, default: true
  end

  def down
    change_column :mesin_roles, :it_can_be_deleted, :boolean, null: false, default: false
  end
end
