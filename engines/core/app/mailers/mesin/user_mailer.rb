module Mesin
  class UserMailer < Devise::Mailer
    helper :application
    include Devise::Controllers::UrlHelpers
    default template_path: "devise/mailer"
    layout "mesin_mailer"

    def self_unlock_instructions current_user
      @current_user = current_user
      mail(template_path: "mesin/user_mailer", to: current_user.email, subject: "Unlock Instructions")
    end
  end
end
