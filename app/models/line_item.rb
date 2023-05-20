class LineItem < ApplicationRecord
  DEFAULT_NUMBER_OF_LINE_ITEMS = 5
  
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true
  
  validates :product_id, uniqueness: { scope: :cart_id }, if: :cart
  
  paginates_per DEFAULT_NUMBER_OF_LINE_ITEMS
  
  def total_price
    product.price * quantity
  end
end
