class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  class Error < StandardError
  end

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end
end
