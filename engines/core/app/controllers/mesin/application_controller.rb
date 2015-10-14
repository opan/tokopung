module Mesin
  class ApplicationController < ActionController::Base
    # include Pundit to gain access Pundit feature
    include Pundit

    layout :choose_layout
    before_action :authenticate_user!

    protected

    def choose_layout
      # if sign in or sign up use 'authentication' layout
      if devise_controller? and (controller_name.eql? "sessions" or controller_name.eql? "registrations")
        "mesin/authentication"
      end

    end
  end # end ApplicationController
end
