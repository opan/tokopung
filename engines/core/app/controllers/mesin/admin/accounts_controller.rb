module Mesin
  class Admin::AccountsController < ApplicationController
    def index

    end

    def update_profile
      if current_user.update_attributes(permit_params)
        @msg        = "Your profile successfully updated."
      else
        @msg        = current_user.errors.full_messages
        @status     = FAILS
      end

      respond_format
    end

    def reload_list_email
      
    end

    def add_user_emails
      if current_user.update_attributes(permit_params)
        @msg        = "Your email successfully added"
      else
        @msg        = current_user.errors.full_messages
        @status     = FAILS
      end

      respond_format
    end

    private

      def permit_params
        params.require(:account).permit(:email, :role, 
          profile_attributes: [:username, :fullname, :birthdate, :homephone, :mobilephone],
          emails_attributes: [:email, :status]
        )
      end
  end
end
