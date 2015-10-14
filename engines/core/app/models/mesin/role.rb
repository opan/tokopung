module Mesin
  class Role < ActiveRecord::Base

    validates_presence_of :created_at, :updated_at, :role_name
    validates :role_name, uniqueness: true, length: {maximum: 50}

    class << self
      def super_admin
        where(role_name: "super_admin").take      
      end

      def admin
        where(role_name: "admin").take
      end
    end # end self
  end
end
