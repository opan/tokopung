require "spec_helper"

module Mesin
  describe UserPolicy do
    subject {described_class}

    let(:user) {create(:user, :valid_email)}
    let(:superadmin) {create(:role, :superadmin)}
    let(:customer) {create(:role, :customer)}

    permissions :index?, :update_profile?, :add_user_emails?, :delete_user_email?, 
      :update_password?, :delete_account?, :lock_account? do
      context "when user not exists" do
        it "access denied" do
          expect(subject).not_to permit(nil, Mesin::User)
        end
      end

      context "when user exists" do
        it "access granted" do
          superadmin
          customer

          expect(subject).to permit(user, Mesin::User)
        end
      end
    end
  end
end
