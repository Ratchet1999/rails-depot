class AddUserReferenceToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :users, foreign_key: true
  end
end
