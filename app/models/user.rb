class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_secure_password
  has_many :orders, dependent: :destroy, foreign_key: :users_id
  has_many :line_items, through: :orders

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, allow_blank: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_destroy :ensure_an_admin_remains
  after_create_commit :welcome_mail
  before_update :ensure_not_admin
  before_destroy :ensure_not_admin

  class Error < StandardError
  end

  private

  def admin?
    email == ADMIN_EMAIL
  end
  
  def ensure_not_admin
    if admin?
      errors.add :base, 'Cannot Update or Delete Admin User'
      throw :abort
    end
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
