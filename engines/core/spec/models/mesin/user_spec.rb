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

  end # end describe User
end
