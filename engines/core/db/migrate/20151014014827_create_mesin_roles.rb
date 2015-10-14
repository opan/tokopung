class CreateMesinRoles < ActiveRecord::Migration
  def up
    create_table :mesin_roles do |t|
      t.string :role_name, limit: 50, null: false
      t.boolean :it_can_be_deleted, default: false, null: false

      t.timestamps null: false
    end

    add_index :mesin_roles, :role_name, unique: true
  end

  def down
    drop_table :mesin_roles
  end
end
