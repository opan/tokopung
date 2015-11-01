require "spec_helper"

module Mesin
  describe Role do
    

    context "if :it_can_be_deleted is false" do
      it "role can not be deleted  and should not raise error when reload" do
        super_admin = create(:role, :super_admin)
        super_admin.destroy
        expect {super_admin.reload}.not_to raise_error
      end
    end

    describe "#it_can_be_deleted?" do
      context "if :it_can_be_deleted is true" do
        it "return true" do
          deleted_role = build(:deleted_role)
          expect(deleted_role.it_can_be_deleted).to eq true
        end
      end

      context "if role 'super_admin'" do
        it "cannot be deleted" do
          super_admin = build(:role, :super_admin)
          expect(super_admin.it_can_be_deleted?).to eq false 
        end
      end

      context "if role 'admin'" do
        it "cannot be deleted" do
          admin = build(:role, :admin)
          expect(admin.it_can_be_deleted?).to eq false
        end
      end

      context "if role 'customer'" do
        it "cannot be deleted" do
          customer = build(:role, :customer)
          expect(customer.it_can_be_deleted?).to eq false
        end
      end
    end # end describe

    context "if :it_can_be_deleted is true" do
      it "role can be deleted" do
        deleted_role = create(:deleted_role)
        deleted_role.destroy
        expect {deleted_role.reload}.to raise_error
      end
    end

    it "role can't more than 50 char" do
      expect {create(:role, role_name: [*1..100].join("-"))}.to raise_error
    end

    describe "#still_used_by_user?" do
      context "if users not empty?" do
        it "return false" do
          create(:role, :customer)
          super_admin = create(:role, :super_admin)
          user = create(:user, :valid_email, role: super_admin.id)

          expect(super_admin.still_used_by_user?).to eq false
        end
      end
    end

    it "role can't be destroyed if still used by user" do
      create(:role, :customer)
      super_admin = create(:role, :super_admin, it_can_be_deleted: true)
      user = create(:user, :valid_email, role: super_admin.id)
      super_admin.destroy
      
      expect {super_admin.reload}.not_to raise_error
    end

    it "role_name must unique" do
      create(:role, :super_admin)
      expect {create(:role, :super_admin)}.to raise_error
    end

    it "role_name must exists" do
      expect {create(:nil_role_name)}.to raise_error
    end

    it ":roles have many :users through :role_users" do
      super_admin = create(:role, :super_admin)
      expect {super_admin.users}.not_to raise_error
    end

    it ":roles have many :role_users" do
      super_admin = create(:role, :super_admin)
      expect {super_admin.role_users}.not_to raise_error
    end
  end # end describe Role
end
