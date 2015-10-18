require "spec_helper"

module Mesin
  describe User do 
    
    it "cant create user if invalid email" do
      FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      expect(FactoryGirl.build(:user, :invalid_email)).not_to be_valid
    end

    it "email can't be nil" do
      FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
    end

    it "email must unique" do
      FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      FactoryGirl.create(:user, :valid_email)
      expect {FactoryGirl.create(:user, :valid_email)}.to raise_error
    end

    it "user have many roles through role_users" do
      FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      user = FactoryGirl.create(:user, :valid_email)

      expect {user.roles}.not_to raise_error
    end

    it "user have many role_users dependent on destroy" do
      FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      user = FactoryGirl.create(:user, :valid_email)
      user.destroy

      expect(user.role_users).to be_empty
    end

    it "set_default_role method must return role customer if role blank" do
      customer = FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      user = FactoryGirl.build(:user, :valid_email)
      expect(user.set_default_role).to eq customer.id
    end

    it "role_super_admin_if_table_blank? method must set role as super_admin if table user still blank" do
      customer = FactoryGirl.create(:role, :customer)
      super_admin = FactoryGirl.create(:role, :super_admin)
      user = FactoryGirl.build(:user, :valid_email)
      expect(user.role_super_admin_if_table_blank?).to eq super_admin.id
    end

    it "check_role_users method must create record in \n
      table role_users if role_users with current user id and role id not exist" do
      customer = FactoryGirl.create(:role, :customer)
      super_admin = FactoryGirl.create(:role, :super_admin)
      user = FactoryGirl.create(:user, :valid_email)
      user.check_role_users
      expect(user.role_users).not_to be_empty
    end

  end # end describe User
end
