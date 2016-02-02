module Mesin
  class Role < ActiveRecord::Base

    validates_presence_of :role_name

    # validasi hanya boleh memasukkan alphanumeric dan underscore
    validates :role_name, uniqueness: true, length: {maximum: 50}, format: /\A\w+\z/i
    validates :role_title, length: {maximum: 50}

    has_many :role_users
    has_many :users, through: :role_users, foreign_key: :role_id

    before_destroy :it_can_be_deleted?, :still_used_by_user?

    class << self
      # override method_missing pada methods
      # jika tidak sesuai kondisi call 'super', untuk memanggil method_missing yang asli
      def method_missing method_sym, *args, &block
        method_string = method_sym.to_s
        if method_string.match /\Aget_/
          method_query_get_prefix method_string
        else
          super
        end
      end

      # pastikan selalu gunakan juga method "respond_to?" agar tidak terjadi trace error
      # http://blog.enriquez.me/2010/2/21/dont-forget-about-respond-to-when-implementing-method-missing/
      def respond_to? method_string, include_private = false
        if method_string.match /\Aget_/
          true
        else
          super(method_string)
        end
      end

      # private method
      private
        def method_query_get_prefix method_string
          role = method_string.split("get_")[1]
          Mesin::Role.where(role_name: role).take
        end
    end # end self

    # check if this "role" deleteable
    def it_can_be_deleted?
      if not self.it_can_be_deleted
        errors.add(:base, "This role can't be deleted.")
        false
      end
    end

    # jika masih ada user yang memiliki role ybs
    def still_used_by_user?
      false if not self.users.empty?
    end

  end # end Role
end
