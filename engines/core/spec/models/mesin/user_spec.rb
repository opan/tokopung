require "spec_helper"

module Mesin
  describe User do 
    before do
      @customer = FactoryGirl.create(:role, :customer)
      @super_admin = FactoryGirl.create(:role, :super_admin)
    end

    it "cant create user if invalid email" do
      expect(FactoryGirl.build(:user, :invalid_email)).not_to be_valid
    end

    it "email can't be nil" do
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
    end

    it "email must unique" do
      FactoryGirl.create(:user, :valid_email)
      expect {FactoryGirl.create(:user, :valid_email)}.to raise_error
    end

    it "user have many roles through role_users" do
      user = FactoryGirl.create(:user, :valid_email)

      expect {user.roles}.not_to raise_error
    end

    it "user have many role_users dependent on destroy" do
      user = FactoryGirl.create(:user, :valid_email)
      user.destroy

      expect(user.role_users).to be_empty
    end

    describe "#set_default_role" do
      context "if role blank" do
        it "return role customer" do
          user = FactoryGirl.build(:user, :valid_email)
          expect(user.set_default_role).to eq @customer.id
        end
      end
    end

    describe "#role_super_admin_if_table_blank?" do
      context "if table user still blank" do
        it "set role as super_admin " do
          user = FactoryGirl.build(:user, :valid_email)
          expect(user.role_super_admin_if_table_blank?).to eq @super_admin.id
        end
      end
    end

    describe "#check_role_users" do
      it "must create record in table role_users if role_users with current user id and role id not exist" do
        user = FactoryGirl.create(:user, :valid_email)
        user.check_role_users
        expect(user.role_users).not_to be_empty
      end
    end

  end # end describe User
end
