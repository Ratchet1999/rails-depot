class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items

  validates :url, :description, :permalink, :title, presence: true

  with_options allow_blank: true do
    validates :url, url: true
    validates :title, uniqueness: true
    validates_with PriceValidator
    validates :permalink, uniqueness: true, format: { with: PERMALINK_REGEX }
    validates :description, format: { with: DESCRIPTION_REGEX }
    validates :image_url, format: { with: IMAGE_URL_REGEX, message: 'must be a URL for GIF, JPG or PNG image.' }
    validates :price, numericality: { greater_than_or_equal_to: MINIMUM_PRICE }
    validates :discount_price, numericality: { greater_than_or_equal_to: MINIMUM_PRICE }
    validates :discount_price, numericality: { less_than_or_equal_to: :price, message: "Discount Price can't be greater than Original Price" }, if: :price 
  end
  
  before_validation :set_discount_price, unless: :discount_price?
  before_validation :set_title, unless: :title?
  
  private

  def set_title
    self.title = 'abc'
  end

  def set_discount_price
    self.discount_price = price
  end
end
