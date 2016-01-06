module Mesin
  class Admin::AccountsController < ApplicationController
    def index

    end

    def update_profile
      if current_user.update_attributes(permit_params)
        @msg        = "Your profile successfully updated."
        @status     = SUCCESS
      else
        @msg        = current_user.errors.full_messages
        @status     = FAILS
      end
      render_json
    end

    private

      def permit_params
        params.require(:form_profile).permit(:email, :role, profile_attributes: [:username, :fullname, :birthdate, :homephone, :mobilephone])
      end
  end
end
