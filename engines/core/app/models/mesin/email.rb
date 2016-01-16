module Mesin
  class Email < ActiveRecord::Base
    belongs_to :user, foreign_key: :user_id
    validates :email, length: {maximum: 100}, uniqueness: true, presence: true
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    before_save :check_email_status
    before_destroy :check_user_emails

    def check_email_status
      if self.status.blank?
        self.status = "secondary"
      end
    end # check_email_status

    def check_user_emails
      if user.emails.length.eql? 1
        errors.add(:base, "You must have at least one emails.")
        false
      end
    end
  end
end
