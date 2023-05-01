class ChangeImageurlFromProducts < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :products, :image_url, :text
      end
      dir.down do
        change_column :products, :image_url, :string
      end
    end

  end
end
