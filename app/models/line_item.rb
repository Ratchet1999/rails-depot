class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true
  validates :product, uniqueness: {scope: :cart}
  def total_price
    product.price * quantity
  end
end
