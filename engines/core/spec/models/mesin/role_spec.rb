require "spec_helper"

module Mesin
  describe Role do
    it "has an super admin role user" do
      expect(FactoryGirl.build(:role, :super_admin)).to be_valid 
    end
  end  
end
