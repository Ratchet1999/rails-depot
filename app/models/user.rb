class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_secure_password
  has_many :orders, dependent: :destroy, foreign_key: :users_id
  has_many :line_items, through: :orders

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}

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
