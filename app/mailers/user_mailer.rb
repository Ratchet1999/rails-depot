class UserMailer < ApplicationMailer
  def registered(user)
    @user = user
    @greeting = "Welcome"

    mail(to: user.email, subject: 'Sign Up Confirmation')
  end
end
