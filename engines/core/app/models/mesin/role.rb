module Mesin
  class Role < ActiveRecord::Base

    validates_presence_of :role_name
    validates :role_name, uniqueness: true, length: {maximum: 50}

    has_many :role_users
    has_many :users, through: :role_users, foreign_key: :role_id, primary_key: :id

    before_destroy :it_can_be_deleted?, :still_used_by_user?

    class << self
      def super_admin
        where(role_name: "super_admin").take      
      end

      def admin
        where(role_name: "admin").take
      end

      def customer
        where(role_name: "customer").take
      end
    end # end self

    def it_can_be_deleted?
      # check if this "role" deleteable
      if not self.it_can_be_deleted
        errors.add(:base, "This role can't be deleted.")
        false
      end
    end

    def still_used_by_user?
      false if not self.users.empty?
    end
  end # end Role
end
