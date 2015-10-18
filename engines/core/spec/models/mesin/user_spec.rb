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

    it "default role user is customer if role blank" do
      customer = FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      user = FactoryGirl.build(:user, :valid_email)
      expect(user.set_default_role).to eq customer.id
    end

    

  end # end describe User
end
