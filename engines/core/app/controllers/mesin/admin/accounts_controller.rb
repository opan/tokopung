module Mesin
  class Admin::AccountsController < ApplicationController
    # verify controller is it already authorized by Pundit
    after_action :verify_authorized
    
    before_action do |c|
      authorize current_user
    end

    def update_profile
      if current_user.update_attributes(permit_params)
        @msg        = "Your profile successfully updated."
        @status     = SUCCESS
      else
        @msg        = current_user.errors.full_messages
        @status     = FAILS
      end

      respond_format
    end

    def add_user_emails
      if current_user.update_attributes(permit_params)
        @msg        = "Your email successfully added"
        @status     = SUCCESS
      else
        @msg        = current_user.errors.full_messages
        @status     = FAILS
      end

      respond_format
    end

    def delete_user_email
      email         = Email.find(params[:id])
      if email.destroy
        @msg        = "Your email successfully destroyed."
        @status     = SUCCESS
      else
        @msg        = email.errors.full_messages
        @status     = FAILS
      end

      respond_format
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
