module Mesin
  class Role < ActiveRecord::Base

    validates_presence_of :created_at, :updated_at, :role_name
    validates :role_name, uniqueness: true, length: {maximum: 50}

    has_many :role_users
    has_many :users, through: :role_users, foreign_key: :role_id, primary_key: :id

    before_destroy :it_can_be_deleted?, :check_has_many


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

    def check_has_many
      arr_data    = []

      Mesin::Role.reflect_on_all_associations(:has_many).map do |assoc|
        if not assoc.name.to_s.eql? "role_users"
          arr_data << [send(assoc.name).table_name, assoc.options[:primary_key]] if !send(assoc.name).empty?
        end
      end

      arr_data.each do |a|
        errors.add(a[1], "is being used in table #{a[0]}")
      end

      if arr_data.length.eql?(0) then return true else return false end
    end
  end # end Role
end
