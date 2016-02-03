module Mesin
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable # :omniauthable,
           # :timeoutable disable Devise module timeoutable

    validates :email, uniqueness: true, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    has_many :role_users, dependent: :destroy # delete "role_users" when "users" destroyed
    has_many :roles, through: :role_users, foreign_key: :user_id
    has_many :emails, foreign_key: :user_id, dependent: :delete_all # using :delete to skip :before_destroy callback in Email
    has_one :profile, dependent: :destroy # every user have one profile to setup
    accepts_nested_attributes_for :profile, :emails

    before_create :role_superadmin_if_table_blank
    before_validation :set_default_role
    after_save :check_role_users, :create_default_emails

    # set default role as "customer" if empty
    def set_default_role
      self.role ||= Mesin::Role.get_customer.id  
    end

    # if table user still empty, create default user with 'superadmin' role
    def role_superadmin_if_table_blank
      if not Mesin::User.exists?
        self.role = Mesin::Role.get_superadmin.id
      end
    end

    # check if already have a record with same role_id
    def check_role_users
      if not role_users.exists? role_id: role
        role_users.create(role_id: role, user_id: id)
      end
    end

    # create default email di table Emails jika masih kosong
    def create_default_emails
      if emails.blank?
        emails.create(email: email, label: "primary")
      end
    end

    # override method_missing pada instance_methods
    # jika tidak sesuai kondisi call 'super', untuk memanggil method_missing yang asli
    def method_missing method_sym, *args, &block
      name_string = method_sym.to_s
      if name_string.match /\Ais_he_an_\w+\?\z/i
        method_query_is_he_an_prefix name_string
      else
        super
      end
    end

    # pastikan selalu gunakan juga method "respond_to?" agar tidak terjadi trace error
    # http://blog.enriquez.me/2010/2/21/dont-forget-about-respond-to-when-implementing-method-missing/
    def respond_to? method_string, include_private = false
      if method_string.match /\Ais_he_an_\w+\?\z/i
        true
      else
        super
      end
    end

    private 
      def method_query_is_he_an_prefix method_sym
        role_name = method_sym.split("is_he_an_")[1].gsub /\?/, ""
        roles.where(role_name: role_name).exists?
      end
  end # end class User
end
