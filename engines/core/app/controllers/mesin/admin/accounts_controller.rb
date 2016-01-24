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

    def update_password

      if current_user.valid_password? params[:current_password]
        if current_user.update_attributes(permit_params)
          @msg      = "Password has successfully changed"
          @status   = SUCCESS
        else
          @msg      = current_user.errors.full_messages
          @status   = FAILS
        end
      else
        @msg        = "Invalid password. Make sure for type correctly."
        @status     = FAILS
      end

      respond_format
    end

    def delete_account
      if current_user.valid_password? params[:current_password]
        current_user.destroy
        @msg      = "Your account successfully destroyed."
        @status   = SUCCESS
      else
        @msg        = "Invalid password. Make sure for type correctly."
        @status     = SUCCESS

      end

      redirect_to admin_accounts_url, notice: @msg      
    end

    private

      def permit_params
        params.require(:account).permit(:email, :role, :password, :password_confirmation,
          profile_attributes: [:username, :fullname, :birthdate, :homephone, :mobilephone, :id],
          emails_attributes: [:email, :status, :id]
        )
      end

      def params_email
        params.require(:email).permit(:email, :status)
      end
  end
end
