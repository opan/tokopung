module Mesin
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, # :omniauthable,
           :timeoutable

    validates :email, uniqueness: true, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    before_create :create_default_user

    def create_default_user
      # if table user still empty, create default user with 'super_admin' role
      if not Mesin::User.exists?
        self.role = Mesin::Role.super_admin.id  
      end
    end

  end
end
