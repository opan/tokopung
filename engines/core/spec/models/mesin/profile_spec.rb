require 'spec_helper'

module Mesin
  describe Profile, type: :model do
    before do
      @customer = create(:role, :customer)
      @super_admin = create(:role, :super_admin)
      @user = create(:user, :valid_email)
    end
  end
end # end module Mesin
