module Mesin
  class Admin::AccountsController < ApplicationController
    # verify controller is it already authorized by Pundit
    after_action :verify_authorized
    
    before_action do |c|
      authorize current_user
    end

    layout :choose_layout

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
      # before change password, check the old password
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
      # before destroying account, check for current password
      # if valid then continue destroying account
      if current_user.valid_password? params[:current_password]
        current_user.destroy
        @msg      = "Your account successfully destroyed."
        @status   = SUCCESS
        
        redirect_to mesin.admin_accounts_url, notice: @msg
      else
        @msg        = "Invalid password. Make sure for typing correctly."
        @status     = SUCCESS

        redirect_to mesin.admin_accounts_url, error: @msg
      end

    end

    def lock_account
      # before locking account, check current password user
      # if valid then continue locking account, send confirmation_token into user email, and sign out
      if current_user.valid_password? params[:current_password]
        @token = Devise.token_generator.generate Mesin::User, :unlock_token
        current_user.update_columns unlock_token: @token[1], locked_at: DateTime.now

        Mesin::UserMailer.self_unlock_instructions(current_user, @token[0]).deliver_now
        @msg        = "You've successfully lock your account. Check your email for Unlock Instructions."
        redirect_to main_app.root_url 
      else
        @msg        = "Invalid password. Make sure for typing correctly"
        redirect_to mesin.admin_accounts_url 
      end
    end

    def test
    end

    private
      def choose_layout
        if action_name.eql? "test"
          "mesin/layout_test"
        end
      end

      def permit_params
        params.require(:account).permit(:email, :role, :password, :password_confirmation,
          profile_attributes: [:username, :fullname, :birthdate, :homephone, :mobilephone, :id],
          emails_attributes: [:email, :status, :id]
        )
      end
  end
end
