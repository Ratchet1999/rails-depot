class AddLineItemsCountToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :line_items_count, :integer, from: nil, to: 0
  end
end
