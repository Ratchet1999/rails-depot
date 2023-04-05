class AddLineItemsCountToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :line_items_count, :string
    change_column_default :carts, :line_items_count, from: nil, to: 0
  end
end
