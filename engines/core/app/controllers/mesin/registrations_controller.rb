module Mesin
  class RegistrationsController < Devise::RegistrationsController
    private

      def sign_up_params
        params.require(resource_name).permit(:email, :password, :password_confirmation, :role, profile_attributes: [:username, :user_id, :profile_id])
      end
  end
end
