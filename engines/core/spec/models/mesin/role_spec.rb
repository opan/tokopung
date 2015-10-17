require "spec_helper"

module Mesin
  describe Role do
    it "default role super admin can not be deleted" do
      super_admin = FactoryGirl.create(:role, :super_admin)
      expect(super_admin.it_can_be_deleted?).to eq false 
    end

    it "default role admin can not be deleted" do
      admin = FactoryGirl.create(:role, :admin)
      expect(admin.it_can_be_deleted?).to eq false
    end

    it "default role customer can not be deleted" do
      customer = FactoryGirl.create(:role, :customer)
      expect(customer.it_can_be_deleted?).to eq false
    end
  end  
end
