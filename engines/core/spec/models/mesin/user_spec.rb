require "spec_helper"

module Mesin
  describe User do 
    before do
      @customer = create(:role, :customer)
      @superadmin = create(:role, :superadmin)
    end

    context "when invalid email" do
      it "can't create user" do
        expect(build(:user, :invalid_email)).not_to be_valid
      end
    end

    context "when valid email" do
      it "can create user" do
        expect(build(:user, :valid_email)).to be_valid
      end
    end

    context "when email nil" do
      it "can't create user" do
        expect(build(:user, email: nil)).not_to be_valid
      end
    end

    it "email must unique" do
      create(:user, :valid_email)
      expect {create(:user, :valid_email)}.to raise_error
    end

    it "user have many roles through role_users" do
      user = create(:user, :valid_email)
      expect {user.roles}.not_to raise_error
    end

    it "user have many role_users dependent on destroy" do
      user = create(:user, :valid_email)
      user.destroy
 
      expect(user.role_users).to be_empty
    end

    describe "#set_default_role" do
      context "if role blank" do
        it "return role customer" do
          user = build(:user, :valid_email)
          expect(user.set_default_role).to eq @customer.id
        end
      end
    end

    describe "#role_superadmin_if_table_blank" do
      context "if table user still blank" do
        it "set role as superadmin " do
          user = build(:user, :valid_email)
          expect(user.role_superadmin_if_table_blank).to eq @superadmin.id
        end
      end
    end

    describe "#check_role_users" do
      context "when role_users with current id role id is not exists" do
        it "must create record in table role_users" do
          user = create(:user, :valid_email)
          user.check_role_users
          expect(user.role_users).not_to be_empty
        end
      end
    end

    describe "#create_default_emails" do
      context "when email with current_user empty on table emails" do
        it "create email" do
          user = create(:user, :valid_email)
          expect(user.emails.exists?).to eql true
        end
      end

      it "label is primary" do
        user = create(:user, :valid_email)
        expect(user.emails.first.label).to eql "primary" 
      end 
    end

    describe "#method_missing" do
      context "when method_name suffix is 'is_he_an_'" do
        it "respond_to method is_he_an_admin? is true" do
          user = create(:user, :valid_email)
          expect(user.respond_to?(:is_he_an_superadmin?)).to eq true
        end

        it "check is user equal with role/word after 'is_he_an_' prefix" do
          user = create(:user, :valid_email)
          expect(user.is_he_an_superadmin?).to eq true
        end
      end

      context "when method_name out of condition " do
        it "raise method_missing" do
          user = create(:user, :valid_email)
          expect {user.test_error}.to raise_error NoMethodError
        end
      end
    end

  end # end describe User
end
