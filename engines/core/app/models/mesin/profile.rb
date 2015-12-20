module Mesin
  class Profile < ActiveRecord::Base
    belongs_to :user

    validates_presence_of :username

    validates :username, :websites, length: {maximum: 100}
    validates :fullname, length: {maximum: 255}
    validates :mobilephone, :homephone, length: {maximum: 12}
    validates :address, length: {maximum: 350}

  end
end
