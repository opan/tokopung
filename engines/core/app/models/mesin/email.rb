module Mesin
  class Email < ActiveRecord::Base
    belongs_to :user, foreign_key: :user_id
    validates :email, length: {maximum: 100}, uniqueness: true, presence: true
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :label, length: {maximum: 20}

    before_save :check_email_label, :only_have_one_primary_email
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

    # one user only have one primary email (is_primary: true)
    # update all emails user have into false, then set current is_primary to true 
    # if user doesn't have primary email and or is_primary false, check first
    # that users have primary email before, if user doesn't have, then force set current email to true
    def only_have_one_primary_email
      if is_primary.eql? true
        # use #update_all to skip validation and callbacks in Mesin::Email model
        Mesin::Email.update_all(is_primary: false, user_id: user_id)
        self.is_primary = is_primary
      else
        get_primary_email = Mesin::Email.where(is_primary: true, user_id: user_id)

        if get_primary_email.blank?
          self.is_primary = true
        end
      end
    end

  end
end
