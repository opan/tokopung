module Mesin
  class Admin::DashboardsController < ApplicationController
    before_action do |c|
      authorize current_user
    end
  end
end
