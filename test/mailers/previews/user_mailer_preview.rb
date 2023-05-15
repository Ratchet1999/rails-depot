class UserMailerPreview < ActionMailer::Preview
  def registered
    UserMailer.registered
  end
end
