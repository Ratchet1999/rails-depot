class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_destroy :ensure_an_admin_remains
  after_create_commit :welcome_mail
  before_update :user_type
  before_destroy :check_user_type

  class Error < StandardError
  end

  private

  def check_user_type
    if self.email == "admin@depot.com"
      raise 'Cannot remove admin'
    end
  end

  def welcome_mail
    UserMailer.registered(self).deliver_later
  end

  def user_type?
    if self.email == "admin@depot.com"
      raise "Admin details can't be updated"
    end
  end

  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end
end
