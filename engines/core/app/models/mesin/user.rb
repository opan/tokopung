module Mesin
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, # :omniauthable,
           :timeoutable

    validates :email, uniqueness: true, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    has_many :role_users, dependent: :destroy # delete "role_users" when "users" destroyed
    has_many :roles, through: :role_users, foreign_key: :user_id
    has_many :emails, foreign_key: :user_id, dependent: :destroy
    has_one :profile, dependent: :destroy # every user have one profile to setup
    accepts_nested_attributes_for :profile, :emails

    before_create :role_super_admin_if_table_blank?
    before_validation :set_default_role
    after_save :check_role_users, :create_default_emails

    def set_default_role
      # set default role as "customer" if empty
      self.role ||= Mesin::Role.customer.id  
    end

    def role_super_admin_if_table_blank?
      # if table user still empty, create default user with 'super_admin' role
      if not Mesin::User.exists?
        self.role = Mesin::Role.super_admin.id  
      end
    end

    def check_role_users
      # check if already have a record with same role_id
      if not role_users.exists? role_id: role
        role_users.create(role_id: role, user_id: id)
      end
    end

    def create_default_emails
      if emails.blank?
        emails.create(email: email, status: "primary")
      end
    end
  end # end class User
end
