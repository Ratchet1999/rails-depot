class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_exception
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items

  validates :url, presence: true, url: true
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :permalink, uniqueness: true, format: { with: PERMALINK_REGEX}
  validates :description, format: {with: DESCRIPTION_REGEX}

  with_options allow_blank: true do
    validates_with PriceValidator
    validates :image_url, format: { with: IMAGE_URL_REGEX, message: 'must be a URL for GIF, JPG or PNG image.'}
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }
    validates :discount_price, numericality: {less_than_or_equal_to: :price, message: "Discount Price can't be greater than Original Price"}, if: :price 
  end
  
  before_validation :set_discount_price
  before_validation do |product|
    product.title = 'abc' unless product.title
  end

  scope :enabled_products, -> {where(enabled:true)}
  scope :products_ordered, -> {joins(:line_items).distinct}
  scope :product_title, ->{products_ordered.pluck(:title)}
end
