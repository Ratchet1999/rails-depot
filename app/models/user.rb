class User < ApplicationRecord
  has_secure_password

  with_options presence: true do
    validates :name
    validates :email, allow_blank: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  end

  after_destroy :ensure_an_admin_remains
  class Error < StandardError
  end

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end
end
