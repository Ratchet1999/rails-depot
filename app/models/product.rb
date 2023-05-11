class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  with_options presence: true do
    validates :url, url: true
    validates :description, :permalink
    validates :title, uniqueness: true
  end

  with_options allow_blank: true do
    validates_with PriceValidator
    validates :permalink, uniqueness: true, format: { with: PERMALINK_REGEX }
    validates :description, format: { with: DESCRIPTION_REGEX }
    validates :image_url, format: { with: IMAGE_URL_REGEX, message: 'must be a URL for GIF, JPG or PNG image.' }
    validates :price, numericality: { greater_than_or_equal_to: MINIMUM_PRICE }
    validates :discount_price, numericality: { less_than_or_equal_to: :price, message: "Discount Price can't be greater than Original Price" }, if: :price 
  end

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
