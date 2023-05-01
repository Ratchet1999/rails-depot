class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registered.subject
  #
  def registered(user)
    @greeting = "Welcome"

    mail to: user.email
  end
end
