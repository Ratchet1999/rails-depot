class ChangeImageurlFromProducts < ActiveRecord::Migration[7.0]
  def change
        change_column :products, :image_url, :text
  end
end
