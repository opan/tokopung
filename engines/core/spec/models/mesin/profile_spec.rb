require 'spec_helper'

module Mesin
  describe Profile, type: :model do
    before do
      @customer = create(:role, :customer)
      @superadmin = create(:role, :superadmin)
    end

    let(:user) {create(:user, :valid_email)}

    context "when username presence" do
      it "success create profile" do
        expect(user.profile.username.blank?).to eq false
      end
    end

    context "when username invalid" do
      it "failed create profile" do
        expect {create(:invalid_profile_username)}.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end # end module Mesin
