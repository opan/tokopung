module Mesin
  class Admin::AccountsController < ApplicationController
    # skip_after_action :verify_authorized, only: :index

    def index
      authorize current_user
    end

    def update_profile
      authorize current_user

      if current_user.update_attributes(permit_params)
        @msg        = "Your profile successfully updated."
      else
        @msg        = current_user.errors.full_messages
        @status     = FAILS
      end

      respond_format
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

    def update_user_emails
      authorize current_user
    end

    def delete_user_emails
      authorize current_user
    end

    private

      def permit_params
        params.require(:account).permit(:email, :role, 
          profile_attributes: [:username, :fullname, :birthdate, :homephone, :mobilephone, :id],
          emails_attributes: [:email, :status, :id]
        )
      end

      def params_email
        params.require(:email).permit(:email, :status)
      end
  end
end
