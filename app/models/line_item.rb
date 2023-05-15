class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true
  
  validates :product_id, uniqueness: { scope: :cart_id }, if: :cart
  
  paginates_per DEFAULT_NUMBER_OF_PAGES
  
  def total_price
    product.price * quantity
  end
end
