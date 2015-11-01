require "spec_helper"

module Mesin
  describe RoleUser do
    before do
      @role_customer = create(:role, :customer)
      @role_super_admin = create(:role, :super_admin)
      @user = create(:user, :valid_email)
    end

    it "role users belongs_to user" do
      expect {Mesin::RoleUser.first.user}.not_to raise_error
    end

    it "role users belongs_to role" do
      expect {Mesin::RoleUser.first.role}.not_to raise_error
    end
  end # end describe RoleUSer
end
