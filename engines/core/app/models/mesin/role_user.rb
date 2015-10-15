module Mesin
  class RoleUser < ActiveRecord::Base

    validates_presence_of :role_id, :user_id, :users, :roles
    validates_numericality_of :role_id, :user_id

    validates_uniqueness_of :user_id, scope: [:role_id]

    belongs_to :users, primary_key: :id, foreign_key: :user_id 
    belongs_to :roles, primary_key: :id, foreign_key: :role_id 
  end
end
