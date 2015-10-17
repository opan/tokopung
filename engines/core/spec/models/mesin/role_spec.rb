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
  end  
end
