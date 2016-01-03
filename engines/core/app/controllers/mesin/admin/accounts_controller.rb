module Mesin
  class Admin::AccountsController < ApplicationController
    def index
      @current_user = current_user
    end
  end
end
