module Mesin
  class Profile < ActiveRecord::Base
    belongs_to :user

    validates_presence_of :username
    validates_numericality_of :user_id

    validates :username, length: {maximum: 100}
    validates :fullname, length: {maximum: 255}

  end
end
