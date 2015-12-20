class AddFieldInProfiles < ActiveRecord::Migration
  def up
    add_column :mesin_profiles, :websites, :string, limit: 100
    add_column :mesin_profiles, :homephone, :string, limit: 12
    add_column :mesin_profiles, :mobilephone, :string, limit: 12
    add_column :mesin_profiles, :address, :string, limit: 350
  end

  def down
    remove_column :mesin_profiles, :websites    
    remove_column :mesin_profiles, :homephone    
    remove_column :mesin_profiles, :mobilephone   
    remove_column :mesin_profiles, :address 
  end
end
