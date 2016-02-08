module MesinHelper
  def main_app
    Rails.application.class.routes.url_helpers
  end

  def emails_test
    ActionMailer::Base.deliveries
  end
end
