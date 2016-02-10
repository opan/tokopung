module Mesin
  class UserMailer < Devise::Mailer
    # include roadie-rails to make inline css
    include Roadie::Rails::Automatic
    
    helper :application
    # as Devise documentation
    include Devise::Controllers::UrlHelpers
    default template_path: "devise/mailer"
    layout "mesin_mailer"


    def self_unlock_instructions current_user, token
      @current_user = current_user
      @token = token
      mail(template_path: "mesin/user_mailer", to: current_user.email, subject: "Unlock Instructions")
    end
  end
end
