module Mesin
  class UserPolicy < ApplicationPolicy
    attr_reader :user, :record

    def initialize user, model
      @user = user
      @model = model
    end

    def index?
      user.present?
    end

    def update_profile?
      user.present?      
    end

    def add_user_emails?
      user.present?
    end

    def delete_user_email?
      user.present?
    end

    def update_user_email?
      user.present?
    end
  end
end
