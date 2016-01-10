module Mesin
  class ApplicationController < ActionController::Base
    # include Pundit to gain access Pundit feature
    include Pundit

    layout :choose_layout
    before_action :authenticate_user!, :set_default_instance_variable

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

    private

      def set_default_instance_variable
        @status = SUCCESS
      end

    protected

      def choose_layout
        # if sign in or sign up use 'authentication' layout
        if devise_controller? and (controller_name.eql? "sessions" or controller_name.eql? "registrations")
          "mesin/authentication"
        end

      end

  end # end ApplicationController
end
