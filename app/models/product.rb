class Product < ApplicationRecord
  class PriceValidator < ActiveModel::Validator
    def validate(record)
      unless record.price > record.discount_price
        record.errors.add :price, "Discount Price Can't be greater than Original Price!"
      end
    end
  end
  class UrlValidator < ActiveModel::Validator
    def validate_each(record, attribute, value)
      unless value =~ %r{\.(gif|jpg|png)\z}i
        record.errors.add(attribute,
          (options[:message] || "is not an approriate Image URL format")
        )
      end
    end
  end
  # validates_with PriceValidator
  validates :url, presence: true, url: true
  validates :title, :description, presence: { message: "can't be blank"}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {with: %r{\.(gif|jpg|png)\z}i, message: 'must be a URL for GIF, JPG or PNG image.'}
  validates :permalink, uniqueness: true, format: {with: /[^[:alnum:]|-]/i}
  validates :hyphenated, length: {minimum: 3, message: "Permalink must be of minimum 3 characters"}, allow_blank: true
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

   def hyphenated
    permalink&.split("-")
   end

   def words_in_description
    description&.split
   end
end

