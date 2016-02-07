require 'spec_helper'

module Mesin
  describe Email, type: :model do
    before(:each) do
      @superadmin = create(:role, :superadmin)
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

    describe "#check_email_label" do
      context "if already default email" do
        it "label must be 'secondary'" do
          @user.emails.create(email: "additional@email.com")
          expect(@user.emails.where(email: "additional@email.com", label: "secondary").exists?).to eql true
        end
      end
    end

    describe "#check_user_emails" do
      context "if user only have one email" do
        it "cancel deleting email" do
          
          expect {@user.emails.destroy_all}.to raise_error ActiveRecord::RecordNotDestroyed
        end
      end

      context "if user more than one email" do
        it "success deleting email" do
          @user.emails.create(email: "test@rspec.com")

          expect(@user.emails.where(email: "test@rspec.com").take.destroy).to be_valid
        end
      end
    end

    describe "#only_have_one_primary_email" do
      context "if user have multiple email" do
        context "when user set other email into primary email" do
          it "that new email will be primary email" do
            @user.emails.create email: "baru@email.com", is_primary: true
            expect(@user.emails.where(email: "baru@email.com").take.is_primary).to eq true
          end
        end
      end

      context "if user only have one email" do
        it "that one email must be primary email" do
          expect(@user.emails.first.is_primary).to eq true
        end
      end
    end

  end
end
