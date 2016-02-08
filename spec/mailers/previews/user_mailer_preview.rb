# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def unlock_instructions
    UserMailer.unlock_instructions(Mesin::User.first, "faketoken", {})
  end

  def self_unlock_instructions
    UserMailer.self_unlock_instructions(Mesin::User.first)
  end
end
