require "spec_helper"

module Mesin
  RSpec.describe UserMailer, type: :mailer do
    before(:each) do
      @superadmin = create(:role, :superadmin)
      @customer = create(:role, :customer)
      @user     = create(:user, :valid_email)
    end

    describe "#self_unlock_instructions" do
      it "must send email" do
        Mesin::UserMailer.self_unlock_instructions(@user, "faketoken").deliver_now
        expect(emails_test.count).to be 1
      end

      it "subject must be 'Unlock Instructions'" do
        Mesin::UserMailer.self_unlock_instructions(@user, "faketoken").deliver_now
        expect(emails_test.first.subject).to eq "Unlock Instructions"
      end

      it "renders the receivers email" do
        Mesin::UserMailer.self_unlock_instructions(@user, "faketoken").deliver_now
        expect(emails_test.first.to).to eq [@user.email]
      end

    end
  end
end
