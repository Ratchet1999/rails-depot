class CreateAddQuantityToLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :add_quantity_to_line_items do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end
