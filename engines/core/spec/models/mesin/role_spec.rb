require "spec_helper"

module Mesin
  describe Role do
    
    describe "#method_missing" do
      context "when method_name prefix is 'get_'" do
        it "respond_to method get_superadmin is true" do
          expect(Mesin::Role.respond_to?(:get_superadmin)).to eq true
        end

        it "get the role record coresponding word after get_ prefix" do
          superadmin = create(:role, :superadmin)
          expect(superadmin.role_name).to eq "superadmin"
        end
      end

      context "when method_name out of condition" do
        it "raise method_missing" do
          expect {Mesin::Role.test_invalid_method}.to raise_error NoMethodError
        end
      end
    end

    context "when role_name not passed regex /\A\w+\z/i" do 
      it "failed create role" do
        expect {create(:invalid_role_name)}.to raise_error ActiveRecord::RecordInvalid
      end
    end

    describe "#check_role_is_deletable" do
      context "when it_can_be_deleted is false" do
        it "failed destroy role" do
          superadmin = create(:role, :superadmin)
          expect(superadmin.destroy).to eq false 
        end
      end

      context "when it_can_be_deleted is true" do
        it "success destroy role" do
          admin = create(:role, :admin)
          admin.destroy
          expect(Mesin::Role.get_admin).to be_nil
        end
      end
    end


    context "when role_name more than 50 char" do
      it "failed create role" do
        expect {create(:role, role_name: [*1..100].join("-"))}.to raise_error ActiveRecord::RecordInvalid
      end
    end


    describe "#check_still_used_by_user" do
      context "when users not empty?" do
        it "return false" do
          create(:role, :customer)
          superadmin = create(:role, :superadmin)
          user = create(:user, :valid_email, role: superadmin.id)

          expect(superadmin.check_still_used_by_user).to eq false
        end
      end

      context "when users empty?" do
        it "success destroy role" do
          admin = create(:role, :admin)
          admin.destroy
          expect(Mesin::Role.get_admin).to be_nil
        end
      end
    end


    it "role_name must unique" do
      create(:role, :superadmin)
      expect {create(:role, :superadmin)}.to raise_error
    end

    it "role_name must exists" do
      expect {create(:nil_role_name)}.to raise_error
    end

    it ":roles have many :users through :role_users" do
      superadmin = create(:role, :superadmin)
      expect {superadmin.users}.not_to raise_error
    end

    it ":roles have many :role_users" do
      superadmin = create(:role, :superadmin)
      expect {superadmin.role_users}.not_to raise_error
    end
  end # end describe Role
end
