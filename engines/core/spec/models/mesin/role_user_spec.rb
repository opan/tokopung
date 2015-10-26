require "spec_helper"

module Mesin
  describe RoleUser do
    it "role users belongs_to user" do
      FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      FactoryGirl.create(:user, :valid_email)

      expect {Mesin::RoleUser.first.user}.not_to raise_error
    end

    it "role users belongs_to role" do
      FactoryGirl.create(:role, :customer)
      FactoryGirl.create(:role, :super_admin)
      FactoryGirl.create(:user, :valid_email)

      expect {Mesin::RoleUser.first.role}.not_to raise_error
    end

  end # end describe RoleUSer
end
