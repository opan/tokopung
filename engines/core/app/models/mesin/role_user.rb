module Mesin
  class RoleUser < ActiveRecord::Base

    validates_presence_of :role_id, :user_id, :user, :role
    validates_numericality_of :role_id, :user_id

    validates_uniqueness_of :user_id, scope: [:role_id]

    belongs_to :user, primary_key: :id, foreign_key: :user_id 
    belongs_to :role, primary_key: :id, foreign_key: :role_id 
  end
end
