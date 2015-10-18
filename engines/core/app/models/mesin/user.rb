module Mesin
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, # :omniauthable,
           :timeoutable

    validates :email, uniqueness: true, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    has_many :role_users, dependent: :destroy # delete "role_users" when "users" destroyed
    has_many :roles, through: :role_users, foreign_key: :user_id, primary_key: :id

    before_create :create_default_user
    before_validation :set_default_role
    after_save :check_role_users

    def set_default_role
      # set default role as "customer" if empty
      self.role ||= Mesin::Role.customer.id  
    end

    def create_default_user
      # if table user still empty, create default user with 'super_admin' role
      if not Mesin::User.exists?
        self.role = Mesin::Role.super_admin.id  
      end
    end

    def check_role_users
      if not role_users.exists? role_id: role
        role_users.create(role_id: role, user_id: id)
      end
    end

  end # end class User
end
