class User < ApplicationRecord
  has_secure_password
  
  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_destroy :ensure_an_admin_remains
  after_create_commit :welcome_mail
  before_update :ensure_not_admin
  before_destroy :ensure_not_admin

  class Error < StandardError
  end

  private

  def ensure_not_admin
    errors.add :base, 'Cannot Update or Delete Admin User'
    throw :abort
  end

  def welcome_mail
    UserMailer.registered(self).deliver_later
  end

  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end
end
