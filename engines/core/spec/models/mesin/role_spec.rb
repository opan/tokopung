require "spec_helper"

module Mesin
  describe Role do
    it "default role super admin test method it_can_be_deleted? must result false" do
      super_admin = FactoryGirl.build(:role, :super_admin)
      expect(super_admin.it_can_be_deleted?).to eq false 
    end

    it "default role admin test method it_can_be_deleted? must result false" do
      admin = FactoryGirl.build(:role, :admin)
      expect(admin.it_can_be_deleted?).to eq false
    end

    it "default role customer test method it_can_be_deleted? must result false" do
      customer = FactoryGirl.build(:role, :customer)
      expect(customer.it_can_be_deleted?).to eq false
    end

    it "role can not be deleted if it_can_be_deleted is false and should not raise error when reload" do
      super_admin = FactoryGirl.create(:role, :super_admin)
      super_admin.destroy
      expect {super_admin.reload}.not_to raise_error
    end

    it "method it_can_be_deleted? should return true if it_can_be_deleted is true" do
      deleted_role = FactoryGirl.build(:deleted_role)
      expect(deleted_role.it_can_be_deleted).to eq true
    end

    it "role can be deleted if it_can_be_deleted is true and raise error when reload" do
      deleted_role = FactoryGirl.create(:deleted_role)
      deleted_role.destroy
      expect {deleted_role.reload}.to raise_error
    end

    it "role can't more than 50 char" do
      expect {FactoryGirl.create(:role, role_name: [*1..100].join("-"))}.to raise_error
    end

    it "method :still_used_by_user? must return false if users not empty" do
      FactoryGirl.create(:role, :customer)
      super_admin = FactoryGirl.create(:role, :super_admin)
      user = FactoryGirl.create(:user, :valid_email, role: super_admin.id)

      expect(super_admin.still_used_by_user?).to eq false
    end

    it "role can't be destroyed if still used by user" do
      FactoryGirl.create(:role, :customer)
      super_admin = FactoryGirl.create(:role, :super_admin, it_can_be_deleted: true)
      user = FactoryGirl.create(:user, :valid_email, role: super_admin.id)
      super_admin.destroy
      
      expect {super_admin.reload}.not_to raise_error
    end

    it "role_name must unique" do
      FactoryGirl.create(:role, :super_admin)
      expect {FactoryGirl.create(:role, :super_admin)}.to raise_error
    end

    it "role_name must exists" do
      expect {FactoryGirl.create(:nil_role_name)}.to raise_error
    end

    it ":roles have many :users through :role_users" do
      super_admin = FactoryGirl.create(:role, :super_admin)
      expect {super_admin.users}.not_to raise_error
    end

    it ":roles have many :role_users" do
      super_admin = FactoryGirl.create(:role, :super_admin)
      expect {super_admin.role_users}.not_to raise_error
    end
  end # end describe Role
end
