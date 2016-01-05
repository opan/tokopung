module Mesin
  class Admin::AccountsController < ApplicationController
    def index
      @current_user = current_user
    end

    def update_profile
      debugger
      p "opan"
      # if current_user.update_attributes(permit_params)
      #   @msg        = "Your profile successfully updated."
      #   @status     = 
      # else
      # end
      render_json
    end

    private

    def permit_params
      params.require(:form_profile).permit(:email, :role, profile_attributes: [:username, :fullname, :birthdate, :homephone, :mobilephone])
    end
  end
end
