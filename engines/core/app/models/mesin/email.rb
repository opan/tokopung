module Mesin
  class Email < ActiveRecord::Base
    belongs_to :user, foreign_key: :user_id
    validates :email, length: {maximum: 100}, uniqueness: true, presence: true
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :label, length: {maximum: 20}

    before_save :check_email_label
    before_destroy :check_user_emails

    # if is_primary = true, then set label to "Primary"
    # else set label to "secondary"
    def check_email_label
      if is_primary.eql? true
        self.label = "primary"
      else
        self.label = "secondary"
      end
    end # check_email_label

    # user must have at least one emails
    def check_user_emails
      if user.emails.length.eql? 1
        errors.add(:base, "You must have at least one emails.")
        false
      end
    end
  end
end
