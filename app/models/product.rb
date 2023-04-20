class Product < ApplicationRecord

  validates_with PriceValidator
  validates :url, presence: true, url: true
  validates :title, :description, presence: { message: "can't be blank"}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: IMAGE_URL_REGEX, message: 'must be a URL for GIF, JPG or PNG image.'}
  validates :permalink, uniqueness: true, format: { with: PERMALINK_REGEX, message: 'is not in valid format'}
  validates :price, numericality: { greater_than_or_equal_to: 0.01 },if: :price
  validates :price, numericality: {greater_than: :discount_price, message: "Discount Price can't be greater than Original Price"}
  validates :words_in_description, length: { in: 5..10 }

  has_many :line_items
  has_many :orders, through: :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item

  private
  
  # ensure that there are no line items referencing this product
   def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
   end

   def words_in_description
    description&.split
   end
end

