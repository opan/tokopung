require 'spec_helper'

module Mesin
  describe Email, type: :model do
    before(:each) do
      @super_admin = create(:role, :super_admin)
      @customer = create(:role, :customer)
      @user = create(:super_admin)
    end

    describe "add user emails" do
      context "if email valid" do
        it "has default emails" do
          expect(@user.emails.exists?).to eql true
        end 

        it "success create additional email " do
          @user.emails.create(email: "additional@email.com")
          expect(@user.emails.where(email: "additional@email.com").exists?).to eql true
        end
      end

      context "if email invalid" do
        it "failed create additional email" do
          @user.emails.create(email: "additional.com")
          expect(@user.emails.where(email: "additional.com").exists?).to eql false
        end 
      end
    end

  end
end
