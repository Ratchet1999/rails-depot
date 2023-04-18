class Product < ApplicationRecord
  validates_with PriceValidator
  validates :image_url, presence: true, url: true
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: IMAGE_URL_REGEX, message: 'must be a URL for GIF, JPG or PNG image.'}
  validates :permalink, uniqueness: true, format: { with: PERMALINK_REGEX, message: 'is not in valid format'}
  validates :price, numericality: {greater_than: :discount_price, message: "Discount Price can't be greater than Original Price"}
  validates :words_in_description, length: { in: 5..10 }
  has_many :line_items, dependent: :restrict_with_error
  has_many :order, through: :line_items
  has_many :carts,through: :line_items
  scope :enabled_products, -> {where(enabled:true)}
  scope :products_ordered, -> {joins(:line_items).distinct}
  scope :product_title, ->{products_ordered.pluck(:title)}
  belongs_to :category, counter_cache: true
  after_create_commit :increment_parent_category_products_count, if: :category_parent_present?
  after_destroy_commit :decrement_parent_category_products_count, if: :category_parent_present?
  def hyphenated
    permalink&.split("-")
  end

  def words_in_description
    description&.split
  end

  private

  def increment_parent_category_products_count
    category.parent.increment!(:products_count)
  end

  def decrement_parent_category_products_count
    category.parent.decrement!(:products_count)
  end

  def category_parent_present?
    category.present? && category.parent.present?
  end

end
