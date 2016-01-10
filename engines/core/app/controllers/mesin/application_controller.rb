module Mesin
  class ApplicationController < ActionController::Base
    # include Pundit to gain access Pundit feature
    include Pundit

    layout :choose_layout
    before_action :authenticate_user!
    # Globally rescue Authorization Errors in controller.
    # Returning 403 Forbidden if permission is denied
    rescue_from Pundit::NotAuthorizedError, with: :permission_denied

    def render_json
      render json: {msg: @msg, status: @status, res_data: @res_data}
    end

    def respond_format
      respond_to do |format|
        format.json {render_json}
        format.html 
        format.js
      end
    end

    protected

      def choose_layout
        # if sign in or sign up use 'authentication' layout
        if devise_controller? and (controller_name.eql? "sessions" or controller_name.eql? "registrations")
          "mesin/authentication"
        end

      end

      def permission_denied
        head 403
      end

  end # end ApplicationController
end
