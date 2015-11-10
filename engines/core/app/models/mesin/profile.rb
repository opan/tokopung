module Mesin
  class Profile < ActiveRecord::Base
    belongs_to :users, foreign_key: :user_id

    validates_presence_of :profile_id, :user_id, :username
    validates_numericality_of :profile_id, :user_id
    validates_uniqueness_of :profile_id

    validates :username, length: {maximum: 100}
    validates :fullname, length: {maximum: 255}
  end
end
